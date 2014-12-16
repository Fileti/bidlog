require 'refinements/for_string' # Autoload? How?

class Bid < ActiveRecord::Base
  using Refinements::ForString

  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'
  belongs_to :winner, class_name: "BidResponse", foreign_key: "winner_id"
  
  has_and_belongs_to_many :bidders, class_name: "User"
  has_many :responses, class_name: "BidResponse"

  accepts_nested_attributes_for :bidders, :reject_if => :all_blank, :allow_destroy => true

  # TODO : review names
  # TODO : Change 'status' to 'active'
  scope :active, -> { where(status:true) }
  scope :user_bids, -> (user) { active.where(owner_id: user.id).newest }
#  scope :response_bids, -> (user) do
#    joins(:bidders, :responses)
#    .active
#    .where(bids_users: { user_id: user.id })
#    .where.not(bid_responses: { bidder_id: user.id })
#    .where("bids_users.user_id = bid_responses.bidder_id")
#  end
#
#  scope :responded_bids, -> (user) do
#    joins(:bidders, :responses)
#    .active
#    .where(
#      bids_users: { user_id: user.id },
#      bid_responses: { bidder_id: user.id })
#    .where("bids_users.user_id = bid_responses.bidder_id")
#  end
#

  scope :bids_to_respond, -> (user, bids_responded_ids) do
    joins(:bidders)
    .active
    .newest
    .where(bids_users: { user_id: user.id })
    .where.not(id: bids_responded_ids)
  end

  scope :newest, -> { order(created_at: :desc) }

  def invite!(user)
    if user.is_a?(User)
      bidders << user
      return
    end

    user = { email: user } if user.is_a?(String) && user.email?

    if user.is_a? Hash
      a = User.invite!(user)
      bidders << a
      return
    end

    raise ArgumentError.new("user deve ser um User, email ou hash de parametros para o invite")
  end
end
