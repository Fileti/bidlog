require 'refinements/for_string' # Autoload? How?

class Bid < ActiveRecord::Base
  using Refinements::ForString
  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
  
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'
  has_and_belongs_to_many :bidders, class_name: "User"

  accepts_nested_attributes_for :bidders, :reject_if => :all_blank, :allow_destroy => true

  def invite!(user)
    if user.is_a?(User)
      bidders << user
      return
    end

    user = { email: user } if user.is_a?(String) && user.email?

    if user.is_a? Hash
      bidders << User.invite!(user)
      return
    end

    raise ArgumentError.new("user deve ser um User, email ou hash de parametros para o invite")
  end
end
