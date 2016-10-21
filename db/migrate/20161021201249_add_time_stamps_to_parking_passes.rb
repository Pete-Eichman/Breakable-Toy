class AddTimeStampsToParkingPasses < ActiveRecord::Migration[5.0]
  def change
    add_column(:parking_passes, :created_at, :datetime)
    add_column(:parking_passes, :updated_at, :datetime)
  end
end
