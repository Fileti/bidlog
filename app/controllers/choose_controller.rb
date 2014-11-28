class ChooseController < ApplicationController
  def index
  	@bid = Bid.find(params[:id])
  end

  def chosen
  	bid_chosen = Bid.find(params[:id])
  	id_response = params[:response_id]
  	
	bid_chosen.winner_id = id_response
	bid_chosen.save

	#response = BidResponse.find(params[:response_id])
	#bid_chosen.

  	redirect_to bids_path
  end

end
