class BidResponse < ActiveRecord::Base
  enum status: [:rejected, :accepted]

  belongs_to :bid
  belongs_to :bidder, class_name: 'User' #, foreign_key: 'bidder_id'

  scope :bids_responded, ->(user) do
    joins(:bid)
      .where(bidder: user)
  end

  scope :bids_responded_ids, ->(user) do
    select(:bid_id)
      .where(bidder: user)
      .uniq
  end
end
