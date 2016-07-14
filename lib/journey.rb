require_relative 'station'

class Journey

  MINIMUM_FARE = 1
  PENALTY_FARE = 6

  attr_accessor :entry_station, :route, :complete, :fare

  def initialize(entry_station)
    @fare = PENALTY_FARE
    @route = []
    @entry_station = entry_station
    @route << @entry_station
    @complete = false

  end

  def finish(exit_station)
    @exit_station = exit_station
    @route << @exit_station
    @fare = MINIMUM_FARE
    @complete = true
    self
  end

  def complete?
    @complete
  end


end
