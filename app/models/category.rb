class Category < ApplicationRecord
  has_many :products, through: :product_categories

  validates :name, inclusion: { in: %w[breads cookies desserts cakes muffins sweets pastry rolls] }
end
