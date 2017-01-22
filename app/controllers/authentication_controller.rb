class AuthenticationController < ApplicationController
  # get /login
  def new
  end

  # post /login
  def create
    user = User.find_by(slug: params[:login].to_s.downcase)
    if user.is_a?(User) && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash.now[:alert] = t(:could_not_log_in)
      render :new, status: :unauthorized
    end
  end

  # delete /logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
