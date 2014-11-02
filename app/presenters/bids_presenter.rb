class BidsPresenter < Array
  attr_accessor :bids

  def initialize(bids)
    bids.each { |o| push(BidPresenter.new(o)) }
  end

  def headers
    @headers ||= ['#', 'Observação', 'Bidders', '']
  end
end