class ChooseController < ApplicationController
  def index
  	@bid = Bid.find(params[:bid_id])
  end

  def update
    bid_chosen = Bid.find(params[:bid_id])
    id_response = params[:id]
    
    bid_chosen.winner_id = id_response
    bid_chosen.save

    redirect_to bids_path    
  end
end
