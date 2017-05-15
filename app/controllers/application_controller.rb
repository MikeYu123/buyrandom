class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def authenticate_admin_user!
    current_user.role != 'member'
  end
end
