class CartItemsController < ApplicationController
  skip_before_action :authenticate_user!

  def create
    @cart_item = CartItem.new(cart_item_params)
    authorize @cart_item
    @cart_item.cart = @cart
    @cart.price += @cart_item.product.price * @cart_item.quantity
    @cart.save!
    @cart_item.save!
    redirect_to carts_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    authorize @cart_item
    cart = @cart_item.cart
    cart.price -= @cart_item.product.price * @cart_item.quantity
    cart.save
    @cart_item.destroy
    redirect_to carts_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
