class Bid < ActiveRecord::Base
  belongs_to :parent, class_name: "Bid", foreign_key: "parent_id"
  
  belongs_to :owner, class_name: "User", foreign_key: 'owner_id'
  has_and_belongs_to_many :bidders, class_name: "User"

  def invite!(user)
    if user.is_a?(User)
      bidders << user
      return
    end

    user = { email: user } if user.respond_to?(:email?) && user.email?

    if user.is_a? Hash
      User.invite!(user)
      return
    end

    raise ArgumentError.new("user deve ser um User, email ou hash de parametros para o invite")
  end
end
