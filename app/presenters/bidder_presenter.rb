class BidderPresenter
  attr_accessor :bidder

  delegate :name, :email, to: :bidder

  def initialize(obj) 
    self.bidder = obj
  end


  def name_or_email
    name.present? ? name : email
  end
end