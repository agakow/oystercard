require 'oystercard'

describe Oystercard do

  subject(:card) { Oystercard.new }
  let(:station) {double :station}

  describe '#balance' do
    it 'has a starting balance of zero' do
      expect(card.balance).to eq(0)
    end
  end

  describe '#top_up' do
    it 'tops up card by amount' do
      expect{card.top_up 1 }.to change{card.balance}.by 1
      expect(card.top_up(5)).to eq 6
    end

    it 'it has a maximum balance of 90' do
      card.top_up(Oystercard::MAX_BALANCE)
      expect{card.top_up(1)}.to raise_error "Exceeds £#{Oystercard::MAX_BALANCE} card limit"
    end
  end

  it 'raises an error when balance under 1' do
    expect{card.touch_in(station)}.to raise_error 'Insufficient balance'
  end

  it 'initially has an empty journey history' do
    expect(card.journey).to eq []
  end

  describe '#in_journey?' do
    it 'initialy is not in journey' do
      card.journey << {}
      expect(card).not_to be_in_journey
    end
  end

  describe '#touch_in/touch_out' do

    before :each do
      card.top_up 10
      card.touch_in(station)
    end

    it 'touches card in' do
      expect(card).to be_in_journey
    end

    it 'touches card out' do
      card.touch_out(station)
      expect(card).not_to be_in_journey
    end

    it 'deducts fare on touch_out' do
      expect{card.touch_out(station)}.to change{card.balance}.by(-Oystercard::MIN_FARE)
    end

    it 'stores the entry station' do
      expect(card.entry_station).to eq station
    end

    # it 'erases entry station on touch out' do
    #   card.touch_out(station)
    #   expect(card.entry_station).to eq nil
    # end

    it 'stores journey history' do
      card.touch_out(station)
      expect(card.journey).to eq [{:entry => station, :exit => station}]
    end

  end
end
