class CreateBidResponses < ActiveRecord::Migration
  def change
    create_table :bid_responses do |t|
      t.references :bid, index: true
      t.integer :bidder_id
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
