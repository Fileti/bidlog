class Bid < ActiveRecord::Base
  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
  has_and_belongs_to_many :bidders, class_name: "User"
end
