class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :orders, dependent: :destroy
  has_many :reviews, through: :orders # => def #reviews Product.reviews
  monetize :price_cents
end
