class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :review, dependent: :destroy
  monetize :amount_cents

  validates :status, inclusion: { in: %w[pending accepted delivered] }
  validates :product, :user, :address, :quantity, :amount, presence: true
end
