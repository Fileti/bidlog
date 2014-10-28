require 'rails_helper'

RSpec.describe "bids/show", :type => :view do
  before(:each) do
    @bid = assign(:bid, Bid.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
