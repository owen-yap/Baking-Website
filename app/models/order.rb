class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :status, inclusion: { in: %w[pending accepted delivered] }
  validates :product, :user, presence: true
end
