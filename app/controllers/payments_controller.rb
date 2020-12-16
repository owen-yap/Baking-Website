class PaymentsController < ApplicationController
  def new
    @order = current_user.orders.where(status: 'pending').find(params[:order_id])
    authorize @order
  end

  def cart_payment
    @cart = current_user.cart
    authorize @cart
  end
end
