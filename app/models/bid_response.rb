class BidResponse < ActiveRecord::Base
  enum status: [:rejected, :accepted]

  belongs_to :bid
  belongs_to :bidder, class_name: 'User' #, foreign_key: 'bidder_id'
end
