class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.string :obs
      t.integer :parent_id

      t.timestamps null: false
    end
  end
end
