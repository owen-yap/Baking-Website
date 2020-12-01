class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_one_attached :photo
  validates :status, inclusion: { in: %w[pending accepted delivered] }
  validates :product, :user, presence: true
end
