class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :initialize_search
  before_action :set_locale

  def initialize_search
    @search = Advert.search(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email]
  end
  
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
