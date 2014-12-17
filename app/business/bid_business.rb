class BidBusiness
  attr_accessor :params, :bid, :current_user
  def initialize(bid, user, params = {})
    self.bid = bid
    self.params = params
    self.current_user = user
  end

  def update
    new_bid = bid.dup
    new_bid.assign_attributes(params)
    new_bid.parent_id = bid.id
    new_bid.bidders = bid.bidders

    ActiveRecord::Base.transaction do
      save_bid(new_bid, :bid_updated_notify)
      bid.status = false
      bid.save
      return new_bid
    end

    false
  end

  def save
    ActiveRecord::Base.transaction do
      save_bid
    end
  end

  def save_bid nbid = nil, notifier = :invite
    nbid ||= bid
    nbid.owner = current_user

    nbid.bidders.each do |bidder|
      bidder.id = invite_or_notify(bidder, notifier)
      bidder.reload
    end

    nbid.save
  end

  def bid_mailer(user, notifier)
    BidMailer.send(notifier, user).deliver_now
  end

  def bid_invite(user)
    user.invite!
    User.find_by email: user.email
  end

  def invite_or_notify(bidder, notifier)
    # TODO nivel tosco master!
    user = User.find_by email: bidder.email
    if user.present?
      bid_mailer(user, notifier)
    else
      user = bid_invite(bidder)
    end
    user.id
  end

  class << self
    def bids_owned(current_user)
      BidsPresenter.new(BidQuery.bids_owned(current_user))
    end

    def bids_to_respond(current_user)
      BidsPresenter.new(BidQuery.bids_to_respond(current_user))
    end

    def bids_responded(current_user)
      BidsPresenter.new(BidQuery.bids_responded(current_user))
    end
  end
end