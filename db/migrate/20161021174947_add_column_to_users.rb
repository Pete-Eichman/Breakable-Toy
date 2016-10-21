class AddColumnToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :booking_id, :integer
  end
end
