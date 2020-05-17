module UsersHelper
  
  def cul_sum(purchase)
    sum = 0
    purchase.goods.each do |good|
      sum += (good.product.price * good.number)
    end
    return sum
  end
  
end
