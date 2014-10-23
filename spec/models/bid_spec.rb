require 'rails_helper'

RSpec.describe Bid, :type => :model do
  it { is_expected.to belong_to :parent }
end
