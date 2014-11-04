class BidResponse < ActiveRecord::Base
  belongs_to :bid
  belongs_to :bidder, class_name: 'User' #, foreign_key: 'bidder_id'
end
