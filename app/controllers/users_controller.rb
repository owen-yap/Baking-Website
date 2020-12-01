class UsersController < ApplicationController
  def index
    # find user
    @user = User.find(params[:id])
    @user_products = @user.products
    @user_orders = @user.orders
  end
end
