class AddOwnerIdToUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :owner_id, :integer, null: false
    add_index :users, :owner_id
  end
end
