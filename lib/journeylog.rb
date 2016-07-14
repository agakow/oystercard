require_relative 'journey'

class JourneyLog
 attr_reader :journeys, :current_journey

  def initialize (journey_class: Journey)
    @journey_class = journey_class
    @journeys = []
    @current_journey = nil
  end

  def start(station)
    @current_journey = @journey_class.new(station)
    @journeys << @current_journey
  end

  def end(station)
    if @current_journey == nil
      @journeys << @journey_class.new(station)
    else
      @current_journey.finish(station)
      @current_journey = nil
    end
  end
end
