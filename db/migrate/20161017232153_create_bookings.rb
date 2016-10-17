class CreateBookings < ActiveRecord::Migration[5.0]
  def change
    create_table :bookings do |t|
      t.belongs_to :parking_pass_id, null: false
      t.belongs_to :user_id, null: false
      t.string :timespan, null: false
    end
  end
end
