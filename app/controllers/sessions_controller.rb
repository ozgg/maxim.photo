class SessionsController < ApplicationController
  # get /login
  def new
    redirect_to root_path unless session[:user_id].nil?
  end

  # post /login
  def create
    if session[:user_id].nil?
      authenticate_user
    else
      redirect_to root_path
    end
  end

  # delete /logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def authenticate_user
    user = User.find_by login: params[:login]
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to login_path
      flash[:notice] = t('sessions.create.invalid_credentials')
    end
  end
end
