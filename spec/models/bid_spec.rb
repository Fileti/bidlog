require 'rails_helper'

RSpec.describe Bid, :type => :model do
  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to(:owner)
                        .with_foreign_key(:owner_id)
                        .class_name('User') }
  it { is_expected.to have_and_belong_to_many(:bidders) }
end
