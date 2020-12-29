class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[new create]

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
    unless current_user.nil?
      @user = current_user
      @order.address = @user.address.to_s
      @order.email = @user.email
    end
    @order.quantity = 1
    @product = Product.find(params[:product_id])
    authorize @order
  end

  def create
    @order = Order.new(order_params)
    authorize @order
    @product = Product.find(params[:product_id])
    # if user not signed in
    if current_user.nil?
      new_user = User.new(email: params[:order][:email], password: params[:order][:contact], username: params[:order][:name], address: "-")
      if new_user.save
        sign_in new_user
        @order.user = new_user
      else
        render :new
        return
      end
    end
    @order.user = current_user unless current_user.nil?
    @order.product = @product
    @order.status = "pending"
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
    authorize @order
  end

  def update
    authorize @order
    if @order.update(order_params)
      redirect_to my_sales_path
    else
      render :edit
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:status, :address, :quantity, :delivery)
  end
end
