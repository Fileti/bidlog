require 'rails_helper'

RSpec.describe BidQuery, type: :model do
  fixtures :users, :bids, :bid_responses
  subject { described_class.new(bid, user) }

  let(:bid) { bids(:bid_com_respostas) }
  let(:user) { bid.owner }

  it '#bids_owned' do
    bids = subject.bids_owned
    expect(bids.count).to eq 3
    expect(bids).to(
      eq(
        [
          bids(:bid1),
          bids(:bid_com_respostas),
          bids(:bid_com_resposta_mesmo_bidder)
        ]
      )
    )
  end

  context 'usuario como bidder' do
    let(:user) { users(:bidder_responde_positivo) }
    it '#bids_responded_ids' do
      expect(subject.bids_responded_ids.collect(&:bid_id)).to(
        eq(
          [
            bids(:bid_com_respostas).id,
            bids(:bid_com_resposta_mesmo_bidder).id
          ]
        )
      )
    end
  end
end