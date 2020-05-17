class AddPaymentToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :payment, :string
  end
end
