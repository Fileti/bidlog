# TODO: mudar esse nome
class BidQuery
  attr_accessor :user
  def initialize(user)
    self.user = user
  end

  def bids_to_respond
    Bid.bids_to_respond(user, bids_responded_ids)
  end

  def bids_responded
    BidResponse.bids_responded(user).collect(&:bid)
  end

  def bids_owned
    user.bids_as_owner.active
  end

  def bids_responded_ids
    BidResponse.bids_responded_ids(user)
  end

  class << self
    def bids_owned(user)
      new(user).bids_owned
    end

    def bids_to_respond(user)
      new(user).bids_to_respond
    end

    def bids_responded(user)
      new(user).bids_responded
    end
  end
end