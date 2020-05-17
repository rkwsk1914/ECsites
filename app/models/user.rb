class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  has_many :baskets
  has_many :putings, through: :baskets, source: :product
  has_many :purchases
  
  def put_in(product, number)
    basket = self.baskets.find_or_create_by(product_id: product.id, number: number)
    basket.status = false
    basket.save
  end
  
  def take_out(product)
    basket = self.baskets.find_by(product_id: product.id)
    basket.destroy if basket
  end
  
  def put_in?(product)
    self.putings.include?(product)
  end 
end
