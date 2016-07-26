require 'journey'

describe Journey do
  subject(:journey) {Journey.new}

  it 'start journey' do
    expect(journey.start_station("station")).to eq("station")
  end

end
