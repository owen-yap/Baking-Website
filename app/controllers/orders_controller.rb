class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = current_user.orders
    @products = policy_scope(Product).order(created_at: :desc)
  end

  def show
    @order = Order.find(params[:id])
    authorize @order
    redirect_to orders_path
  end

  def new
    @order = Order.new
    @user = current_user
    @product = Product.find(params[:product_id])
    @order.quantity = 1
    @order.address = @user.address.to_s
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.product = Product.find(params[:product_id])
    @product = @order.product
    @order.status = "pending"
    authorize @order
    @order.amount = @order.product.price
    if @order.save

      session = Stripe::Checkout::Session.create(
        payment_method_types: ['card'],
        line_items: [{
          name: @product.name,
          images: [@product.photo.key],
          amount: @product.price_cents,
          currency: 'sgd',
          quantity: @order.quantity
        }],
        success_url: order_url(@order),
        cancel_url: order_url(@order)
      )

      @order.update(checkout_session_id: session.id)
      redirect_to new_order_payment_path(@order)
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :address, :quantity)
  end
end
