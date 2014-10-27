class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :invitable
  validates :email, presence: true, uniqueness: true

  has_many :bids_as_owner, class_name: 'Bid', foreign_key: 'owner_id', dependent: :destroy
  has_and_belongs_to_many :bids_as_participant, class_name: 'Bid'
end
