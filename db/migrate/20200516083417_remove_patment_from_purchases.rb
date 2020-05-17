class RemovePatmentFromPurchases < ActiveRecord::Migration[5.2]
  def change
    remove_column :purchases, :patment, :string
  end
end
