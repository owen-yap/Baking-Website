class CartsController < ApplicationController
  skip_before_action :authenticate_user!, only: :index

  def index
    @cart_items = @cart.cart_items
    skip_policy_scope
  end

  def update
    @cart = current_user.cart
    @cart.update(cart_params)
    @cart.cart_items.each do |item|
      order = Order.new
      order.product = item.product
      order.user = @cart.user
      order.quantity = item.quantity
      order.delivery = @cart.delivery
      order.address = @cart.address
      order.amount = item.product.price
      order.status = "pending"
      order.save!
    end

    authorize @cart

    session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [{
        name: "Cart Items",
        amount: @cart.price_cents,
        currency: 'sgd',
        quantity: 1
      }],
      success_url: orders_url,
      cancel_url: carts_url
    )

    @cart.update(checkout_session_id: session.id)
    redirect_to new_cart_payment_path(@cart)
  end

  private

  def cart_params
    params.require(:cart).permit(:delivery, :address)
  end
end
