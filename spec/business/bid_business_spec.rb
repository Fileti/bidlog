require 'rails_helper'

RSpec.describe BidBusiness, type: :model do
  fixtures :bids, :users
  subject { described_class.new(:bid, :user, :params) }

  let(:user) { users(:owner) }
  let(:bid) { bids(:bid1) }
  let(:params) { {} }

  context 'methods' do
    it 'invite_or_notify' do
      u = users(:bidder2)
      send_count = ActionMailer::Base.deliveries.count
      expect(subject.invite_or_notify(u, :bid_updated_notify)).to eq u.id
      expect(ActionMailer::Base.deliveries.count).to eq(send_count + 1)
    end
  end
end