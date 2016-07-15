class Journey
  attr_reader :entry_station, :exit_station, :fare

  PENALTY_FARE = 6
  MINIMUM_FARE = 1

  def initialize(entry_station=nil)
    @entry_station = entry_station
    @fare = PENALTY_FARE
    @complete = false
  end

  def complete?
    !!entry_station && !!exit_station
  end

  # def start_station(station)
  #   @start_station = station
  # end

  def ended(exit_station=nil)
    @exit_station = exit_station
    @complete = true if complete?
    @fare = MINIMUM_FARE if complete?
    self
  end

end
