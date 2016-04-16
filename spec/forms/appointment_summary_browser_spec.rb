require 'rails_helper'

RSpec.describe AppointmentSummaryBrowser do
  subject { described_class.new(page: nil, start_date: nil, end_date: nil) }

  context 'when initializing' do
    it 'defaults the start and end dates' do
      expect(subject.start_date).to eq(1.month.ago.to_date)
      expect(subject.end_date).to eq(Time.zone.today)
    end
  end

  describe '#results' do
    it 'returns results within the provided date range' do
      present = create(:appointment_summary, date_of_appointment: Time.zone.today)
      create(:appointment_summary, date_of_appointment: 1.year.ago)

      expect(subject.results).to match_array(present)
    end

    context 'on postgres `DateStyle` iso, mdy servers (travis-ci)' do
      it 'will not overflow for UK formatted dates' do
        expect do
          described_class.new(
            page: nil,
            start_date: '15/01/2016',
            end_date: '16/01/2016'
          ).results
        end.not_to raise_error
      end
    end
  end
end