class ProductsController < ApplicationController
  include ProductsHelper
  
  before_action :require_user_logged_in

  def stocks
    @products = Product.all
  end
  
  def index
    @products = Product.all
  end
  
  def show
    find_product
  end 
  
  def new
    @product = Product.new
  end 
  
  def create
    @product = Product.new(product_params)
    
    if @product.save
      flash[:success] = @product.name + 'を追加しました。'
      redirect_to root_path
    else
      flash.now[:danger] = '追加に失敗しました。'
      render :new
    end 
  end
  
  def edit
    find_product
  end

  def update
    find_product
    if @product.stock == 0 && @product.status == 'SALE'
      flash.now[:danger] = '在庫が0のため、SALEに設定できません'
      @products = Product.all
      render :stocks
    elsif @product.update(product_params)
      flash[:success] = @product.name + 'のデータを更新しました。'
      redirect_to stocks_products_path
    else
      flash.now[:danger] = '更新失敗しました。'
      @products = Product.all
      render :stocks
    end
  end
  
  def destroy
    find_product
    @product.baskets.destroy_all
    
    @product.destroy
    flash[:success] = @product.name + 'を削除しました。'
    redirect_to root_path
  end
  
  private
  
  def find_product
    @product = Product.find(params[:id])
  end 
  
  def product_params
    params.require(:product).permit(:name, :price, :stock, :explanation, :status)#, :picture)
  end
end
