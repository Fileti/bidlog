require 'rails_helper'

RSpec.describe BidQuery, type: :model do
  fixtures :users, :bids, :bid_responses
  subject { described_class.new(user) }

  let(:user) { users(:owner) }

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

    it '#bids_to_respond' do
      # este usuário já respondeu todos os bids!
      expect(subject.bids_to_respond).to eq []
    end

    context 'usuario com bids_pendentes' do
      let(:user) { users(:bidder_nao_responde) }
      it '#bids_to_respond' do
        expect(subject.bids_to_respond).to(
          eq(
            [
              bids(:bid_com_respostas),
              bids(:bid_com_resposta_mesmo_bidder)
            ]
          )
        )
      end
    end

    context 'bids respondidos' do
      let(:user) { users(:bidder_nao_responde) }
      it '#bids_responded' do
        expect(subject.bids_responded).to eq []
      end

      context 'usuario já com todos respondidos' do
        let(:user) { users(:bidder_responde_positivo) }

        it "#bids_responded" do
          expect(subject.bids_responded).to(
            eq(
              [
                bids(:bid_com_respostas),
                bids(:bid_com_resposta_mesmo_bidder)
              ]
            )
          )
        end
      end
    end
  end
end