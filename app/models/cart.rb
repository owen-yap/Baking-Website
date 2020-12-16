class Cart < ApplicationRecord
  belongs_to :user
  has_many :cart_items, dependent: :destroy
  has_many :products, through: :cart_items
  monetize :price_cents

  validates :delivery, inclusion: { in: %w[delivery self-collection] }
end
