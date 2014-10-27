class CreateJoinTableBidsUsers < ActiveRecord::Migration
  def change
    create_join_table :bids, :users do |t|
      t.index [:bid_id, :user_id]
    end
  end
end
