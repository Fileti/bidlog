class BidPresenter
  attr_accessor :bid

  delegate :id, :obs, to: :bid

  def initialize bid
    @bid = bid
  end

  def bidders
    @bidders ||= bid.bidders.map { |o| BidderPresenter.new(o) }
  end

  def link_to_edit *params, &block
    helpers.link_to routes.edit_bid_path(bid), *params, &block
  end

  def link_to_delete *params, &block
    hash = { 
          method: :delete, 
          data: { confirm: 'Are you sure?' }
        }

    hash = hash.merge params.delete_at(0)  if params.first.is_a?(Hash)

    p = [bid, hash, *params]

    helpers.link_to *p, &block
  end

private
  def helpers
    ApplicationController.helpers
  end

  def routes
    Rails.application.routes.url_helpers
  end
end