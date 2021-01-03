class CartsController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @cart_items = @cart.cart_items
    if user_signed_in?
      @cart.name = current_user.username
      @cart.email = current_user.email
      @cart.address = current_user.address
    end
    skip_policy_scope
  end

  def update
    unless user_signed_in?
      new_user = User.create(username: params[:cart][:name], email: params[:cart][:email], password: [:cart][:contact])
      sign_in new_user
    end
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
      order.name = @cart.name
      order.contact = @cart.contact
      order.email = @cart.email
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
    params.require(:cart).permit(:delivery, :address, :name, :contact, :email)
  end
end
