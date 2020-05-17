class AddPaymentToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :payment, :string
  end
end
