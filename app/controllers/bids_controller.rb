class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :accept, :reject]

  def index
    @bids = BidsPresenter.new(Bid.user_bids(current_user))
    @bids_to_response = BidsPresenter.new(Bid.response_bids(current_user))
    
    respond_with(@bids)
  end

  def show
    respond_with(@bid)
  end

  def new
    @bid = Bid.new
    @bid.owner = current_user
    @bid.bidders.new
    respond_with(@bid)
  end

  def edit
  end

  def create
    # TODO: isolar!
    ActiveRecord::Base.transaction do
      @bid = Bid.new(bid_params)
      @bid.owner = current_user
      @bid.bidders.each do |bidder|
        bidder.invite!
      end
      if @bid.save
        redirect_to bids_path
      else
        respond_with @bid
      end
    end
  end

  def update
    @bid.update(bid_params)
    respond_with(@bid)
  end

  def destroy
    @bid.destroy
    respond_with(@bid)
  end

  #http://localhost:3000/bids/1/accept
  def accept
    response = @bid.responses.new
    response.bidder = current_user
    response.accepted!
    @bid.save
    redirect_to bids_path
  end

  #http://localhost:3000/bids/1/decline
  def reject
    response = @bid.responses.new
    response.bidder = current_user
    response.rejected!
    @bid.save
    redirect_to bids_path
  end

  private
    def set_bid
      @bid = Bid.find(params[:id])
    end

    def bid_params
      params.require(:bid).permit(:obs, bidders_attributes: [:id, :name, :email, :_destroy])
    end
end
