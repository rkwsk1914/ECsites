class CreatePurchases < ActiveRecord::Migration[5.2]
  def change
    create_table :purchases do |t|
      t.references :user, foreign_key: true
      t.string :address
      t.string :patment

      t.timestamps
    end
  end
end
