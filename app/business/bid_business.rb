class BidBusiness
  attr_accessor :params, :bid, :current_user
  def initialize(bid, user, params = {})
    self.bid  = bid
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
      bid.satus = false
      bid.save
    end

    new_bid
  end

  def save
    ActiveRecord::Base.transaction do
      save_bid
    end
  end

  def save_bid notifier = :invite
    bid.owner = current_user

    bid.bidders.each do |bidder|
      bidder.id = invite_or_notify(bidder, notifier)
      bidder.reload
    end

    bid.save
  end

  def bid_mailer(user, notifier)
    BidMailer.send(notifier, user).deliver_now
  end

  def bid_invite(user)
    user.invite!
    User.find_by email: bidder.email
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
end