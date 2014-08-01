require 'app_responder'

class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :initialize_search
  before_action :set_locale

  rescue_from CanCan::AccessDenied, with: :user_not_authorized
  
  self.responder = AppResponder
  respond_to :html

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

  def user_not_authorized
    flash[:alert] = t('flash.errors.not_authorized')
    redirect_to root_path
  end

end
