require 'rails_helper'

RSpec.describe Bid, :type => :model do
  it { is_expected.to belong_to :parent }
  it { is_expected.to have_and_belong_to_many(:bidders)
                        .class_name("User")}
end
