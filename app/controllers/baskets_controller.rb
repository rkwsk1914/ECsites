class BasketsController < ApplicationController
  #before_action :require_user_logged_in
  
  def index
    @baskets = Basket.all
  end
  
  def edit
  end

  def update
    basket = current_user.baskets.find(params[:id])
    hash = params[:basket]
    basket.number = hash[:number] 
    basket.save
    flash[:success] = '個数を変更しました。'
    redirect_back(fallback_location: root_path)
  end

  def create
    product = Product.find(params[:product_id])
    basket = params[:basket]
    number = basket[:number] 
    current_user.put_in(product, number)
    flash[:success] = '買い物かごへ入れました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    product = Product.find(params[:product_id])
    current_user.take_out(product)
    flash[:secondary] = '買い物かごから外しました。'
    redirect_back(fallback_location: root_path)
  end
end
