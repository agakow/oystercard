require_relative 'station'
require_relative 'journey'

class Oystercard
  attr_reader :balance, :entry_station,  :journey, :journey_history


  DEFAULT_BALANCE = 0
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = 1


  def initialize
    @balance = DEFAULT_BALANCE
    @in_journey = nil
    @journey_history = []

  end

  def top_up(amount)
    message = "Balance can not be greater than #{MAXIMUM_BALANCE}"
    fail message if (@balance + amount) > MAXIMUM_BALANCE
    @balance += amount
  end


  def in_journey?
    @in_journey
  end

  def touch_in(station)
    fail "Insufficent funds" if @balance < MINIMUM_BALANCE
    @journey = Journey.new(station)
    @in_journey = true
  end

  def touch_out(station)
    @journey.exit_station(station)
    deduct(@journey.fare)
    @journey_history << @journey.route
    @in_journey = false
  end

private

  def deduct(amount)
    @balance -= amount
  end

end
