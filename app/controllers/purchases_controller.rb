class PurchasesController < ApplicationController
  include UsersHelper
  include PurchasesHelper
  include ProductsHelper
  
  before_action :require_onwer_logged_in, only: [:index]
  
  def index
    @purchases = Purchase.all
  end
  
  def show
    purchase_find
    @goods = @purchase.goods
    @baskets = current_user.baskets
    @baskets.each do |basket|
      good = Good.find_by(product_id: basket.product.id)
      good.number = basket.number
      good.save
    end
  end
  
  def new
    stock_check(current_user.baskets)
    @purchase = current_user.purchases.new
  end

  def create
    @baskets = current_user.baskets
    @purchase = current_user.purchases.new
    set_purchase_data
    
    if @purchase.save
      #flash[:success] = '購入登録しました。'
      @baskets.each do |basket|
        good = @purchase.goods.new(product_id: basket.product.id, number: basket.number)
        good.save
      end
      redirect_to @purchase
    else
      flash.now[:danger] = '追加に失敗しました。'
      render :new
    end 
  end
  
  def edit
    stock_check(current_user.baskets)
    purchase_find
  end
  
  def update
    @baskets = current_user.baskets
    @purchase = Purchase.find(params[:id])
    set_purchase_data
    
    if @purchase.save
      flash[:success] = '購入情報を更新しました。'
      redirect_to @purchase
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end 
  end
  
  def destroy
    purchase_find
    @purchase.goods.destroy_all
    @purchase.destroy
    flash[:success] = '購入をキャンセルしました。'
    redirect_to root_path
  end
  
  def complete
    stock_check(current_user.baskets)
    purchase_find
    @purchase.status = true
    @purchase.save
    reduce_inventory
    current_user.baskets.destroy_all
  end
    
  private
  
  def set_purchase_data
    @purchase.status = false
    @purchase.payment = params[:purchase][:payment]
    
    if params[:purchase][:op] == 'user_address'
      @purchase.address = current_user.address
    elsif params[:purchase][:op] == 'new_address'
      @purchase.address = params[:purchase][:address]
    end
  end
  
  def stock_check(baskets)
    baskets.each do |basket|
      product = basket.product
      
    puts "================================="
    p product.stock
    p all_backet_number(product)
      
      if product.stock < all_backet_number(product)
        flash[:success] = product.name + 'の販売終了しました。'
        redirect_to shoppings_user_path(current_user)
      elsif product.stock == 0
        basket.destory  
        redirect_to shoppings_user_path(current_user)
      end
    end
  end
  
  def all_backet_number(product)
    count = 0
    product.baskets.each do |basket|
      count += basket.number
    end
    return count
  end
  
  def reduce_inventory
    goods = @purchase.goods
    goods.each do |good|
      product = good.product
      product.stock = product.stock-good.number
      if product.stock == 0
        product.status = 'SOLD OUT'
      end
      product.save
    end
  end
  
  def purchase_find
    @purchase = Purchase.find(params[:id])
  end
  
  def purchase_params
    params.require(:purchase).permit(:address, :payment, :op)
  end
end
