require_relative 'journey'

class OysterCard
  attr_reader :balance, :entry_station, :journeys

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1
  MINIMUM_FARE    = 1

  def initialize(balance = 0)
    @balance = balance
    @journeys = []
  end

  def top_up amount
    fail "Max balance of £#{MAXIMUM_BALANCE} exceeded" if amount + balance > MAXIMUM_BALANCE
    @balance += amount
  end

  def in_journey?
    @journeys.last.in_journey?
  end

  def touch_in(station)
    fail "Card has insufficient balance" if @balance < MINIMUM_BALANCE
    @journey = Journey.new(station)
    @journeys << @journey
  end

  def touch_out(station)
    #deduct MINIMUM_FARE
    @journey = Journey.new if @journey == nil
    @journey.ended(station)
  end

  private

  def deduct amount
    @balance -= amount
  end

end
