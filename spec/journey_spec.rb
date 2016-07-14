require 'journey'
require 'station'
require 'oystercard'

describe Journey do
  subject(:journey) {described_class.new(station)}
  let(:station) {double :station, zone: 2}

  it "checks if journey is not complete" do
    expect(subject).not_to be_complete
  end

  it "charges a penalty fare by default" do
    expect(subject.fare).to eq Journey::PENALTY_FARE
  end

  it "returns itself when exiting journey" do
    expect(subject.finish(station)).to eq(subject)
  end

  context "given an entry station" do
    subject {described_class.new(station)}

    it "has an entry station" do
      expect(subject.entry_station).to eq station
    end

    it "returns a penalty fare if no exit station given" do
      expect(subject.fare).to eq Journey::PENALTY_FARE
    end

  context "given an exit station" do
    let(:exit_station) {double :exit_station}

    before do
      subject.finish(exit_station)
    end

    it "calculates a fare" do
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end

    it "knows if a journey is complete" do
      expect(subject).to be_complete
    end

  end

  end

end
