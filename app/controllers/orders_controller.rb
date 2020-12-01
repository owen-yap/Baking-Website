class OrdersController < ApplicationController
  before_action :set_order, only: %i[show edit update destroy]

  def index
    @orders = User.find(current_user).orders
  end

  def show
    @order = Order.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def create
    @order = Order.new
    @order.user = current_user
    @order.product = Product.find(params[:product_id])
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
    params.require(order).permit(:status)
  end
end
