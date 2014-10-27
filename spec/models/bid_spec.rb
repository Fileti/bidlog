require 'rails_helper'

RSpec.describe Bid, :type => :model do
  it { is_expected.to belong_to :parent }
  it { is_expected.to belong_to(:owner)
                        .with_foreign_key(:owner_id)
                        .class_name('User') }
  it { is_expected.to have_and_belong_to_many(:bidders) }

  it '' do
    expect { subject.invite!(1234) }.to raise_error "user deve ser um User, email ou hash de parametros para o invite"
  end
end
