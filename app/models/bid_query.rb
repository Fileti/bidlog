# TODO: mudar esse nome
class BidQuery
  attr_accessor :bid, :user
  def initialize(bid, user)
    self.bid = bid
    self.user = user
  end

  def bids_to_respond
    Bid.joins(:bidders).where(bidder_user: { bidder_id: user.id }).not.where(id: bids_responded_ids)
  end

  def bids_responded
    BidResponse.joins(:bid).where(bidder: user, bid: bid).collect(&:bid)
  end

  def bids_owned
    user.bids_as_owner
  end

  def bids_responded_ids
    BidResponse.select(:bid_id).where(bidder: user).uniq
  end
end