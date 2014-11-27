class ChooseController < ApplicationController
  def index
  	@bid = Bid.find(params[:id])
  end

  def chosen
  	bid_chosen = Bid.find(params[:id])
  	id_response = params[:response_id]
  	
  	puts ('-------------------------------------------------------------------------------------')
  	puts (id_response)
  	puts ('-------------------------------------------------------------------------------------')

  	redirect_to bids_path
  end

end
