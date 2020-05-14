class Product < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :price, presence: true
  validates :status, presence: true
  #validates :picture, presence: true
  validates :stock, presence: true
  validates :explanation, presence: true, length: { maximum: 100 }
end
