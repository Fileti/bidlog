class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :accept, :reject]

  def index
    @bids = BidBusiness.bids_owned(current_user)
    # TODO: change this names
    @bids_to_response = BidBusiness.bids_to_respond(current_user)
    @bids_responded   = BidBusiness.bids_responded(current_user)

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
    flash[:notice] = 'Este bid já tem uma oferta eleita vencedora. Editá-lo irá reabrir o bid e cancelar o aceite!' if @bid.winner.present?
    respond_with(@bid)
  end

  def create
    # TODO: isolar!
    @bid = Bid.new(bid_params)

    if BidBusiness.new(@bid, current_user).save
      redirect_to bids_path
    else
      respond_with @bid
    end
  end

  # TODO: mudar para uma camada de business, mais fácil de testar
  def update
    BidBusiness.new(@bid, current_user, bid_params).update
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
end
