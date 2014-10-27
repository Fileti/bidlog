class Bid < ActiveRecord::Base
  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'

  has_and_belongs_to_many :bidders, class_name: "User"
end
