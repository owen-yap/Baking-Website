class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
    @products = policy_scope(Product).order(created_at: :desc)
    @users = User.all
    # this returns active record relation of users with products
    @sellers = User.joins(:products).group('users.id')

    @markers = @sellers.geocoded.map do |seller|
      {
        lat: seller.latitude,
        lng: seller.longitude,
        infoWindow: render_to_string(partial: "info_window", locals: { seller: seller })
      }
    end

    # raise
  end

  def new
    @product = Product.new
    skip_authorization
  end

  def create
    @product = Product.new(product_params)
    @product.user = current_user

    authorize @product
    if @product.save
      redirect_to product_path(@product)
    else
      render :new
    end
  end

  def show
    skip_authorization
  end

  def edit
    authorize @product
  end

  def update
    authorize @product
    if @product.update(product_params)
      redirect_to product_path(@product.id)
    else
      render :edit
    end
  end

  def destroy
    authorize @product
    @product.destroy
    redirect_to root_path
  end

  def my_products
    @products = current_user.products
    skip_authorization
  end

  def my_sales
    @products = current_user.products
    skip_authorization
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :photo)
  end
end
