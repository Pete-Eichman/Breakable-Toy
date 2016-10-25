class AddLatLongToParkingPasses < ActiveRecord::Migration[5.0]
  def change
    add_column(:parking_passes, :lat, :string, null: false)
    add_column(:parking_passes, :lng, :string, null: false)
  end
end
