class Oystercard
  MAX_BALANCE = 90
  MIN_FARE = 1
  attr_reader :balance, :entry_station, :journey

  def initialize
    @balance = 0
    @journey = []
  end

  def top_up(amount)
    fail "Exceeds £#{MAX_BALANCE} card limit" if limit_reached(amount)
    @balance += amount
  end

  def limit_reached(amount)
    @balance + amount > MAX_BALANCE
  end

  def in_journey?
    @journey.last.key?(:entry)
  end

  def touch_in(station)
    fail 'Insufficient balance' if balance < MIN_FARE
    @journey << {entry: station}
  end

  def touch_out(station)
    deduct(MIN_FARE)
    @journey.last.store(:exit, station)
  end

  private

  def deduct(amount)
    @balance -= amount
  end

end
#
