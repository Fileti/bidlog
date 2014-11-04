require 'rails_helper'

RSpec.describe BidResponse, :type => :model do
  it { is_expected.to belong_to :bid }
end
