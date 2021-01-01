class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :current_customer, :current_cart
  before_action :configure_permitted_parameters, if: :devise_controller?
  include Pundit

  # Pundit: white-list approach.
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username address userphoto seller])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username address userphoto seller])
  end

  # Uncomment when you *really understand* Pundit!
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(root_path)
  end

  def current_cart
    if login?
      if current_user.cart.nil?
        new_cart = Cart.new
        new_cart.user = current_user
        new_cart.save!
      end
      @cart = @user.cart
    else
      if session[:cart]
        @cart = Cart.find(session[:cart])
      else
        @cart = Cart.create(delivery: "self-collection")
        session[:cart] = @cart.id
      end
    end
  end

  private

  def current_customer
    @user = current_user unless current_user.nil?
  end

  def login?
    !!current_customer
  end

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
