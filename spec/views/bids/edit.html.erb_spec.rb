require 'rails_helper'

RSpec.describe "bids/edit", :type => :view do
  before(:each) do
    @bid = assign(:bid, Bid.create!())
  end

  it "renders the edit bid form" do
    render

    assert_select "form[action=?][method=?]", bid_path(@bid), "post" do
    end
  end
end
