require 'rails_helper'

RSpec.describe Bid, :type => :model do
  fixtures :bids, :users

  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to(:owner)
                        .with_foreign_key(:owner_id)
                        .class_name('User') }
  it { is_expected.to have_and_belong_to_many(:bidders) }

  context '#invite' do
    it 'Exceptions on non user' do
      expect { subject.invite!(1234) }.to raise_error "user deve ser um User, email ou hash de parametros para o invite"
    end

    it 'User must add to bidders collection' do
      bid = bids(:bid1)
      b1 = users(:bidder1)
      b2 = users(:bidder2)
      bid.invite!(b1)
      bid.invite!(b2)
      expect(bid.bidders).to eq([b1, b2])
    end
  end
end
