require 'rails_helper'

RSpec.describe "bids/index", :type => :view do
  before(:each) do
    assign(:bids, [
      Bid.create!(),
      Bid.create!()
    ])
  end

  it "renders a list of bids" do
    render
  end
end
