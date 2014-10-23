class Bid < ActiveRecord::Base
  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
end
