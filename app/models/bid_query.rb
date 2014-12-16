# TODO: mudar esse nome
class BidQuery
  attr_accessor :bid, :user
  def initialize(bid, user)
    self.bid = bid
    self.user = user
  end

  def bids_to_respond
    Bid.bids_to_respond(user, bids_responded_ids)
  end

  def bids_responded
    BidResponse.bids_responded(user).collect(&:bid)
  end

  def bids_owned
    user.bids_as_owner
  end

  def bids_responded_ids
    BidResponse.bids_responded_ids(user)
  end
end