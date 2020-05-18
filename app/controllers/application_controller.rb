class ApplicationController < ActionController::Base
  include SessionsHelper
  
  #protect_from_forgery with: :null_session
  
  private

  def create_owner
    unless User.first
      User.create(
        name: 'Site-Owner',
        email: 'onwer@exam.com',
        password: 'siteowner',
        password_confirmation: 'siteowner'
        )
    end
  end

  def require_user_logged_in
    unless logged_in?
      redirect_to root_url
    end
  end
  
  def require_guest_user
    unless logged_in?
      guest_user
    end
  end

  def require_onwer_logged_in
    unless onwer?
      redirect_to root_url
    end
  end
end
