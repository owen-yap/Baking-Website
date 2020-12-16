class CartsController < ApplicationController
  def show
    if current_user.cart.nil?
      new_cart = Cart.new
      new_cart.user = current_user
    end
    @cart = current_user.cart
    authorize @cart
    @cart_items = current_user.cart.cart_items
    @price = 0
  end
end
