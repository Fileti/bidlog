require 'rails_helper'

RSpec.describe Bid, :type => :model do
  fixtures :bids, :users

  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to(:owner)
                        .with_foreign_key(:owner_id)
                        .class_name('User') }
  it { is_expected.to have_and_belong_to_many(:bidders) }

  context '#invite' do
    subject { bids(:bid1) }

    it 'Exceptions on non user' do
      expect { subject.invite!(1234) }.to raise_error "user deve ser um User, email ou hash de parametros para o invite"
    end

    it 'User must add to bidders collection' do
      b1 = users(:bidder1)
      b2 = users(:bidder2)
      subject.invite!(b1)
      subject.invite!(b2)
      expect(subject.bidders).to eq([b1, b2])
    end

    it 'must invite new user if a hash is given' do
      allow(User).to receive(:invite!).with(email: 'someemail@email.com')
      subject.invite!("someemail@email.com")
    end

    it 'must accept hash as params' do
      allow(User).to receive(:invite!).with(name: 'teste', email: 'ee_mail@email.com')
      subject.invite!(name: 'teste', email: 'ee_mail@email.com')
    end
  end
end
