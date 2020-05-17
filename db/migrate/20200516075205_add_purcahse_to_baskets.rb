class AddPurcahseToBaskets < ActiveRecord::Migration[5.2]
  def change
    add_reference :baskets, :purchase, foreign_key: true
  end
end
