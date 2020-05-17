class UsersController < ApplicationController
  include UsersHelper
  
  before_action :require_user_logged_in, except: [:new, :create]
  #before_action :correct_user, only: [:edit, :update]
  
  def index
    @users = User.all #order(id: :desc).page(params[:page]).per(25)
  end
  
  def show
    user_find
    @purchases = @user.purchases
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      flash[:success] = 'ようこそ' + @user.name
      redirect_to login_path
    else
      flash.now[:danger] = 'ユーザー登録に失敗しました。'
      render :new
    end 
  end
  
  def edit
    user_find
  end
  
  def update
    user_find
    if @user.update(user_params)
      flash[:success] = 'アカウント情報を更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'アカウント情報の更新に失敗しました。'
      render :edit
    end
  end
  
#  def destroy
#  end

  def shoppings
    user_find
    @baskets = @user.baskets
  end

  private
  
  def user_find
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :address, :payment)
  end

  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(params[:id])
    end
  end
  
end
