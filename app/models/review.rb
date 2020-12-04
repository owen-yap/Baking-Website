class Review < ApplicationRecord
  belongs_to :order
  validates :rating, inclusion: { in: [1, 2, 3, 4, 5], message: "Please give a rating! :)" }
end
