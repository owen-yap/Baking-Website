class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parammeters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :address])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :address])
  end

end
