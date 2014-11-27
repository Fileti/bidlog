class AddStatusToBid < ActiveRecord::Migration
  def change
    add_column :bids, :status, :boolean, default: true
    add_column :bids, :winner_id, :integer, null: true
    add_index :bids, :winner_id
  end
end
