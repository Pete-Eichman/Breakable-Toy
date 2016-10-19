class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :parking_pass, null: false
      t.belongs_to :user, null: false
      t.string :start_time, null: false
      t.string :end_time, null: false
    end
  end
end
