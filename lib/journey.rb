require_relative 'station'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :route

  def initialize(entry_station)
    @route = []
    @entry_station = entry_station
    @route << @entry_station

  end

  def exit_station(exit_station)
    @exit_station = exit_station
    @route << @exit_station
    self
  end

  def complete?
    @route.size == 2 ? true : false
  end

  def fare
   route.size == 2 ? MINIMUM_FARE : PENALTY_FARE
  end

end
