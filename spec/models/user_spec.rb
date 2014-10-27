require 'rails_helper'

RSpec.describe User, :type => :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_uniqueness_of :email }

  it { is_expected.to have_and_belong_to_many :bids_as_bidder }
  it { is_expected.to have_many(:bids_as_owner)
                        .with_foreign_key(:owner_id)
                        .class_name('Bid')
                        .dependent(:restrict_with_error) }
end
