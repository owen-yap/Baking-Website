class ProductsController < ApplicationController
  before_action :set_product, only: %i[show edit update destroy]
  skip_before_action :authenticate_user!, only: %i[index show]

  def index
    @products = Product.all
    @products = policy_scope(Product).order(created_at: :desc)
  end

  def my_products
    @products = current_user.products
    skip_authorization
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

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :category, :photo)
  end
end
