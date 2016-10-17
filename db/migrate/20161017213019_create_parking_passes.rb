class CreateParkingPasses < ActiveRecord::Migration[5.0]
  def change
    create_table :parking_passes do |t|
      t.belongs_to :user, null: false
      t.belongs_to :booking
      t.string :address, null: false
      t.integer :price_per_hour, null: false
      t.integer :pass_number, null: false
    end
  end
end
