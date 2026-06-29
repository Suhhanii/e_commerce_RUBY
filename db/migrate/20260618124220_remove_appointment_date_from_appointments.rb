class RemoveAppointmentDateFromAppointments < ActiveRecord::Migration[8.1]
  def change
    remove_column :appointments, :appointment_date, :datetime
  end
end
