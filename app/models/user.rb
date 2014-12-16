class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :email, presence: true, uniqueness: true

  has_many :bids_as_owner, class_name: 'Bid', 
                           foreign_key: 'owner_id', 
                           dependent: :restrict_with_error
  has_and_belongs_to_many :bids_as_bidder, class_name: 'Bid'

  has_many :bid_responses, foreign_key: 'bidder_id'

  scope :bids_responded, ->(bid) do
    bid_responses
  end

  def bids_responded(bid = nil)
    if bid
      bid_responses.includes(:bid).where(bid_id: bid.id)
    else
      bid_responses.includes(:bid)
    end
  end
end
