class CreateBaskets < ActiveRecord::Migration[5.2]
  def change
    create_table :baskets do |t|
      t.references :user, foreign_key: true
      t.references :product, foreign_key: true
      t.integer :number
      t.boolean :status

      t.timestamps
      t.index [:user_id, :follow_id], unique: true
    end
  end
end
