class ApplicationController < ActionController::Base
  include SessionsHelper
  
  #protect_from_forgery with: :null_session
  
  private

  def require_user_logged_in
    unless logged_in?
      redirect_to login_url
    end
  end
end
