class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one :review, dependent: :destroy
  monetize :amount_cents

  validates :status, inclusion: { in: %w[pending paid accepted delivered] }
  validates :delivery, inclusion: { in: %w[delivery self-collection] }
  validates :product, :user, :quantity, :amount, :email, :contact, :name, presence: true
end
