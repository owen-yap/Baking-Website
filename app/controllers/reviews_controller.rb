class ReviewsController < ApplicationController
  def new
    @review = Review.new
    @order = Order.find(params[:order_id])
    @review.order = @order
    skip_authorization
  end

  def create
    @review = Review.new(review_params)

    if @review.order
      redirect_to product_path
    end

    @order = Order.find(params[:order_id])
    @review.order = @order

    authorize @review

    if @review.save
      redirect_to product_path(@review.order.product_id)
    else
      render :new
    end
    skip_authorization
  end

  def destroy
    @review = Review.find(params[:id])
    @order = Order.find(@review.order_id)
    authorize @review
    # @orders = current_user.orders
    @review.destroy
    redirect_to product_path(@order.product)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
