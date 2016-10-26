class RemoveNullConstraintPhoneNumber < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :phone_number, :string
    add_column :users, :phone_number, :string
  end
end
