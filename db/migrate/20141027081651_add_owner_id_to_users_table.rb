class AddOwnerIdToUsersTable < ActiveRecord::Migration
  def change
    add_column :bids, :owner_id, :integer, null: false
    add_index :bids, :owner_id
  end
end
