class AddIncomeInRetirementToAppointmentSummaries < ActiveRecord::Migration[4.2]
  def change
    add_column :appointment_summaries, :income_in_retirement, :string
  end
end
