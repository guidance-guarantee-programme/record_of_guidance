# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CreateBatch, '#call' do
  subject(:batch) { described_class.new.call }

  def create_appointment_summary
    AppointmentSummary.create(
      title: 'Mr', last_name: 'Bloggs', date_of_appointment: Time.zone.today,
      reference_number: '123', guider_name: 'Jimmy', guider_organisation: 'tpas',
      address_line_1: '29 Acacia Road', town: 'Beanotown', postcode: 'BT7 3AP',
      country: 'United Kingdom', has_defined_contribution_pension: 'yes',
      income_in_retirement: 'pension', format_preference: 'standard',
      appointment_type: 'standard')
  end

  context 'with no items to be batched' do
    it { is_expected.to be_nil }
    specify { expect { batch }.to_not change { Batch.count } }
  end

  context 'with items to be batched' do
    let!(:appointment_summaries) { Array.new(2) { create_appointment_summary } }

    it { is_expected.to be_a(Batch) }
    specify { expect(batch.appointment_summaries).to eq(appointment_summaries) }

    context 'with supported appointment summaries' do
      shared_examples 'supported appointment summaries' do |supported_state|
        before do
          supported = Array.new(2) do
            create_appointment_summary.tap { |as| as.update_attributes!(supported_state) }
          end

          appointment_summaries.concat(supported)
        end

        it "includes appointment_summaries with #{supported_state}" do
          expect(batch.appointment_summaries).to include(have_attributes(supported_state))
        end
      end

      include_examples 'supported appointment summaries', appointment_type: '50_54'
      include_examples 'supported appointment summaries', country: Countries.non_uk.sample
      include_examples 'supported appointment summaries', format_preference: 'large_text'
    end

    context 'with some unsupported appointment summaries' do
      shared_examples 'ignore unsupported appointment summaries' do |unsupported_state|
        before do
          unsupported = Array.new(2) do
            create_appointment_summary.tap { |as| as.update_attributes!(unsupported_state) }
          end

          appointment_summaries.concat(unsupported)
        end

        it "should ignore appointment_summaries with #{unsupported_state}" do
          expect(batch.appointment_summaries).not_to include(have_attributes(unsupported_state))
        end
      end

      include_examples 'ignore unsupported appointment summaries', format_preference: 'braille'
    end
  end
end
