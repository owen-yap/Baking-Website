class CartItemsController < ApplicationController
  def create
    if current_user.cart.nil?
      new_cart = Cart.new
      new_cart.user = current_user
      new_cart.save!
    end

    cart = current_user.cart
    @cart_item = CartItem.new(cart_item_params)
    authorize @cart_item
    @cart_item.cart = cart
    cart.price += @cart_item.product.price * @cart_item.quantity
    cart.save!
    @cart_item.save!
    redirect_to cart_path(cart)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    authorize @cart_item
    cart = @cart_item.cart
    cart.price -= @cart_item.product.price
    cart.save
    @cart_item.destroy
    redirect_to cart_path(cart)
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:quantity, :product_id)
  end
end
