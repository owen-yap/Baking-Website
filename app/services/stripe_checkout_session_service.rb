class StripeCheckoutSessionService
  def call(event)
    order = Order.find_by(checkout_session_id: event.data.object.id)
    order.update(status: 'paid')
    cart = Cart.find_by(checkout_session_id: event.data.object.id)
    cart.cart_items.each do |item|
      # Cart logic here
    end
  end
end
