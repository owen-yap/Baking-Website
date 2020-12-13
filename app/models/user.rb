class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :products, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_one_attached :userphoto
  has_many :reviews, through: :orders, dependent: :destroy
  has_one :cart

  # @user.seller? => true or false
  def seller?
    seller
  end
end
