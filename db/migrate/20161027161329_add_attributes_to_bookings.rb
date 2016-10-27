class AddAttributesToBookings < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :first_name, :string, null: false
    add_column :bookings, :last_name, :string, null: false
    add_column :bookings, :phone_number, :string, null: false
    add_column :bookings, :date, :date, null: false
  end
end
