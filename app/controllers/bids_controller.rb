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
    @bid = Bid.find(params[:id])
    respond_with(@bid)
  end

  def create
    # TODO: isolar!
   
    @bid = Bid.new(bid_params)
    save_bid @bid
    
    if save_bid @bid
        redirect_to bids_path
    else
      respond_with @bid
    end

  end

  def update
    new_bid = @bid.dup
    new_bid.parent_id = @bid.id
    new_bid.bidders = @bid.bidders

    save_bid (new_bid)

    #@bid.active? = false
    #@bid.update(bid_params)

    redirect_to bids_path
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

    def save_bid bid
      ActiveRecord::Base.transaction do
        bid.owner = current_user
        
        bid.bidders.each do |bidder|
          bidder.invite!
        end
      
      if bid.save
        true
      else
        false
      end
    end
  end
end
