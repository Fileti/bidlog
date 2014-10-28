class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!

  respond_to :html

  # To verify if a user is signed in, use the following helper:
  # user_signed_in?

  # For the current signed-in user, this helper is available:
  # current_user

  # You can access the session for this scope:
  # user_session
end
