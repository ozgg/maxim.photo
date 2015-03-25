class ApplicationController < ActionController::Base
  before_action :set_locale

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  def default_url_options(options = {})
    if I18n.locale == I18n.default_locale
      { locale: nil }.merge options
    else
      { locale: I18n.locale }.merge options
    end
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) unless session[:user_id].nil?
  end

  protected

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
