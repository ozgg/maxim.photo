class SessionsController < ApplicationController
  # get /login
  def new
    redirect_authorized_user unless current_user.nil?
  end

  protected

  def redirect_authorized_user
    flash[:notice] = t(:already_logged_in)
    redirect_to root_path
  end
end
