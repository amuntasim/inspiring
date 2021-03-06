class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  before_action :set_locale
  before_action :configure_permitted_devise_parameters, if: :devise_controller?

  # http_basic_authenticate_with(
  #     name: ENV.fetch("AUTH_NAME"),
  #     password: ENV.fetch("AUTH_PASSWORD")
  # )

  def store_location
    session[:return_to] = request.url
  end

  def set_locale
    if params[:locale] && AVAILABLE_LOCALES.include?(params[:locale].to_sym)
      I18n.locale = params[:locale].to_sym
      session[:locale] = I18n.locale
    else
      I18n.locale = session[:locale] || I18n.default_locale
    end
    @current_locale = I18n.locale
  end

  def configure_permitted_devise_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :handle])
  end
end
