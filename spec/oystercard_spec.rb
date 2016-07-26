require 'oystercard'
require 'journey'

describe OysterCard do
  subject(:card) {described_class.new}
  let(:station) {double :station}
  #let(:journey) {double :journey}

  describe 'initialize' do

    it 'check new card has balance 0' do
      expect(card.balance).to eq(0)
    end
  end

  describe '#top_up' do

    before do
      card.top_up(50)
    end

    it 'when top_up it changes the balance' do
      expect{card.top_up(10)}.to change{card.balance}.by 10
    end

    it 'raises an error if the maximum balance is exceeded' do
      maximum_balance = OysterCard::MAXIMUM_BALANCE
      expect{card.top_up(41)}.to raise_error "Max balance of £#{maximum_balance} exceeded"
    end
  end

  describe '#journey' do
    before do
      card.top_up(50)
    end

    it 'is initially not in a journey' do
      allow(card).to receive(:in_journey?).and_return(false)
      expect(card).not_to be_in_journey
    end

    it 'can touch in' do
      card.touch_in(station)
      expect(card).to be_in_journey
    end

    it 'error if card has insufficient balance' do
      50.times {card.touch_in(station)}
      50.times {card.touch_out(station)}
      expect{card.touch_in(station)}.to raise_error "Card has insufficient balance"
    end

    it 'can touch out' do
      card.touch_in(station)
      card.touch_out(station)
      expect(card).not_to be_in_journey
    end
    it 'when touch_out it deducts amount' do
      card.touch_in(station)
      expect{card.touch_out(station)}.to change{card.balance}.by(-OysterCard::MINIMUM_FARE)
    end

    # it 'stores the station entry' do
    #   card.touch_in(station)
    #   #p card.journeys
    #   expect(card.journeys).to include station
    # end

    it 'has an empty list of journeys by default' do
      expect(card.journeys).to be_empty
    end

    let(:journey){double :journey}


    it 'stores a journey' do
      card.touch_in(station)
      card.touch_out(station)
      expect(card.journeys.size).to eq 1
    end
  end
end
