require 'rails_helper'

RSpec.describe Bid, :type => :model do
  fixtures :bids, :users 

  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to(:owner)
                        .with_foreign_key(:owner_id)
                        .class_name('User') }
  it { is_expected.to have_and_belong_to_many(:bidders) }
  it { is_expected.to have_many(:responses) }

  context '#invite' do
    subject { bids(:bid1) }

    it 'Exceção caso o parametro não seja o experado' do
      expect { subject.invite!(1234) }.to raise_error "user deve ser um User, email ou hash de parametros para o invite"
    end

    it 'Adiciona os a coleção de bidders' do
      b1 = users(:bidder1)
      b2 = users(:bidder2)
      subject.invite!(b1)
      subject.invite!(b2)
      expect(subject.bidders).to eq([b1, b2])
    end

    #it 'Aceita hash com parametros minimos' do
    #  allow(User).to receive(:invite!).with(email: 'someemail@email.com')
    #  subject.invite!("someemail@email.com")
    #end

    #it 'Aceita hash como parametros' do
    #  allow(User).to receive(:invite!).with(name: 'teste', email: 'ee_mail@email.com')
    #  subject.invite!(name: 'teste', email: 'ee_mail@email.com')
    #end

    it 'Cria um novo se não existe' do
      subject.invite!(name: 'john', email:'e@mail.com', skip_invitation: true)
      expect(User.where(name: 'john', email: 'e@mail.com').count).to eq(1)
    end

    it 'Já foi convidado, não manda o invite denovo' do
      b1 = users(:bidder1)
      subject.invite!(name: b1.name, email: b1.email) 
      expect(b1.reload.invitations_count).to eq(0)
    end
  end
end
