class Journey
  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @fare = PENALTY_FARE
    @complete = false
  end

  def incomplete?
    !entry_station && !exit_station
  end

  def complete?
    @complete
  end

  def ended(exit_station=nil)
    @exit_station = exit_station
    @complete = true unless incomplete?
    @fare = MINIMUM_FARE unless incomplete?
    self
  end

end
