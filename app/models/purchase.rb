class Purchase < ApplicationRecord
  validates :address, presence: true, length: { maximum: 150 }
  
  belongs_to :user
  has_many :goods
  
  
end
