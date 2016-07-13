require 'oystercard'

describe Oystercard do
  subject(:card) {described_class.new}
  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  credit = 10
  minimum_fare = Journey::MINIMUM_FARE
  penalty_fare = Journey::PENALTY_FARE

  describe 'initialize' do

    it 'check new card\'s balance' do
      expect(subject.balance).to eq(Oystercard::DEFAULT_BALANCE)
    end
it 'checks that card has empty journey history' do
  expect(subject.journey_history).to be_empty
end
  end

  describe '#top_up' do
      it { is_expected.to respond_to(:top_up).with(1).argument}

      it 'increases the balance by the top up amount' do

        expect{subject.top_up(credit)}.to change{ subject.balance }.by credit

      end

      it 'will not allow a balance greater than 90' do
        maximum_balance = Oystercard::MAXIMUM_BALANCE
        subject.top_up(maximum_balance)
        expect {subject.top_up(1)}.to raise_error "Balance can not be greater than #{maximum_balance}"
      end

  end

  describe '#touch_in' do
    it "touches in" do
      subject.top_up(credit)
      subject.touch_in(entry_station)
      expect(subject).to be_in_journey
    end

    it "raises an error if balance is less than minimum fare" do
      expect {subject.touch_in(entry_station)}.to raise_error "Insufficent funds"
    end


  end

  describe '#touch_out' do

    it 'checks that just one journey was created' do
      subject.top_up(credit)
      subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.journey_history.size}.by(1)
    end

    it "touches out" do
      subject.top_up(credit)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
      expect(subject).not_to be_in_journey
    end

  end

    describe '#deduct' do

      it 'deducts the correct fare' do
        subject.top_up(credit)
        subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(- minimum_fare)
      end

      it 'deducts the penalty fare' do
        subject.top_up(credit)
        expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(- penalty_fare)
      end

    end

  describe '#in_journey?' do
    it "is initially not in a journey" do
      expect(subject).not_to be_in_journey
    end

  end
end
