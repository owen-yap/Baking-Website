class ReviewsController < ApplicationController
  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    # orders = current_user.orders
    if @review.save
      redirect_to orders_path(orders)
    else
      render :new
    end
  end

  def destroy
    @review = Review.find(params_review)
    # @orders = current_user.orders
    @review.destroy
    redirect_to orders_path(@orders)
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
