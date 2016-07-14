require_relative 'journey'

class JourneyLog
 attr_reader :journeys

  def initialize (journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
  end

  def start(station)
    @journey = @journey_class.new(station)
    @journeys << @journey
  end

end
