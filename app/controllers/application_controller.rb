class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :set_current_user
  before_filter :initialize_search

  def initialize_search
    @q = Advert.search(params[:q])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << [:name, :email]
  end

  def set_current_user
    User.current_user = current_user
  end

end
