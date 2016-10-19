class ChangeBookings < ActiveRecord::Migration[5.0]
  def change
    remove_column :bookings, :parking_pass_id_id
    remove_column :bookings, :user_id_id
    remove_column :bookings, :timespan

    add_column :bookings, :parking_pass, :, null: false
    add_column :bookings, :user, :belongs_to, null: false
    add_column :bookings, :start_time, :string, null: false
    add_column :bookings, :end_time, :string, null: false
  end
end
