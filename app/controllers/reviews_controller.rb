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
      redirect_to orders_path
    end

    @order = Order.find(params[:order_id])
    @review.order = @order

    authorize @review

    if @review.save
      redirect_to orders_path
    else
      render :new
    end
    skip_authorization
  end

  def destroy
    @review = Review.find(review_params)
    # @orders = current_user.orders
    @review.destroy
    redirect_to orders_path
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
