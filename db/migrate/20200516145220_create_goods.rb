class CreateGoods < ActiveRecord::Migration[5.2]
  def change
    create_table :goods do |t|
      t.references :product, foreign_key: true
      t.integer :number
      t.references :purchase, foreign_key: true

      t.timestamps
    end
  end
end
