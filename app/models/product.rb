class Product < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :orders, dependent: :destroy # => product.orders
  has_many :reviews, through: :orders # => def #reviews Product.reviews
  has_many :categories, through: :product_categories
  monetize :price_cents
end
