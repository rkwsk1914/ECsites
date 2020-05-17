module SessionsHelper
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
  
  def create_guest_user
    @guest_user = User.create(name: 'ゲスト', email: rand.to_s+'@guest.com', password: 'guestpass', password_confirmation: 'guestpass')
    session[:user_id] = @guest_user.id
  end

  def logged_in?
    if current_user
      if current_user.name == 'ゲスト'
        return false
      else
        return true
      end
    else
      create_guest_user
      return false
    end
  end
  
  def basket_counts(user)
    @baskets_count = user.baskets.count
  end
  
  def onwer?
    if current_user && current_user.id == 1
      return true
    else
      return false
    end
  end
end
