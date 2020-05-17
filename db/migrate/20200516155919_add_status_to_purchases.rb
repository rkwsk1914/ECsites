class AddStatusToPurchases < ActiveRecord::Migration[5.2]
  def change
    add_column :purchases, :status, :boolean
  end
end
