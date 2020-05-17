module PurchasesHelper
  
  def status_check(purchase)
    status = purchase.status
    case status
      when false then
        purchase_status = '購入手続き中'
      when true then
        purchase_status = '購入済み'
    end
    
    return purchase_status
  end
end
