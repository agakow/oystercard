require 'journeylog'

describe JourneyLog do
  let(:station) {double :station}
  let(:journey_class){double :journey_class, new: current_journey}
  let(:current_journey){double :current_journey}
  subject {described_class.new(journey_class: journey_class)}

  describe '#initialize' do
    it 'initially expects journeys to be empty' do
      expect(subject.journeys).to be_empty
    end
    it 'initially expects current_journey to be nil' do
      expect(subject.current_journey).to be_falsey
    end
  end

  describe '#start' do
      it 'starts a new journey' do
        expect(journey_class).to receive(:new).with(station)
        subject.start(station)
      end
      it 'creates a current_journey' do
        allow(journey_class).to receive(:new).and_return current_journey
        subject.start(station)
        expect(subject.journeys).to include current_journey
      end
    end

    describe '#finish' do
      context 'complete journey' do
        before :example do
          expect(current_journey).to receive(:finish)
        end
            it 'stores the complete journey' do
            subject.start(station)
            subject.end(station)
            expect(subject.journeys).to include current_journey
          end
            it 'expects current journey to be nil' do
            subject.start(station)
            subject.end(station)
            expect(subject.current_journey).to be_falsey
          end
        end

        context 'incomplete journey' do
          it 'contains only the exit station' do
          subject.end(station)
          p subject.journeys
          expect(subject.journeys).to
          end
        end
    end
end
