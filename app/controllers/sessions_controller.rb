class SessionsController < ApplicationController
  # get /login
  def new
    redirect_authorized_user unless current_user.nil?
  end

  # post /login
  def create
    if current_user.nil?
      verify_credentials
    else
      redirect_authorized_user
    end
  end

  protected

  def redirect_authorized_user
    flash[:notice] = t(:already_logged_in)
    redirect_to root_path
  end

  def invalid_credentials
    flash.now[:notice] = t(:invalid_credentials)
    render :new
  end

  def valid_credentials
    flash[:notice] = t(:logged_in_successfully)
    redirect_to root_path
  end

  def verify_credentials
    user = User.find_by login: params[:login]
    if user.is_a?(User) && user.authenticate(params[:password])
      session[:user_id] = user.id
      valid_credentials
    else
      invalid_credentials
    end
  end
end
