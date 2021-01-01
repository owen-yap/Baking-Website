class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :current_customer, :current_shopping_cart
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

  def current_customer
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def current_shopping_cart
    if login?
      @cart = @user.cart
    else
      if session[:cart]
        @cart = Cart.find(session[:cart])
      else
        @cart = Cart.create(delivery: "self-collection", price_cents: 0)
        raise
        session[:cart] = @cart.id
      end
    end
  end

  def login?
    !!current_customer
  end

  private

  def skip_pundit?
    devise_controller? || params[:controller] =~ /(^(rails_)?admin)|(^pages$)/
  end
end
