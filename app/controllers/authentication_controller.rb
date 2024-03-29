# frozen_string_literal: true

# Authentication with form and OAuth
class AuthenticationController < ApplicationController
  include Biovision::Authentication

  before_action :redirect_authenticated_user, except: %i[new destroy]

  # get /login
  def new
  end

  # post /login
  def create
    user = User[param_from_request(:login).downcase]

    handler = Biovision::Components::UsersComponent[user]
    if handler.authenticate(params[:password], tracking_for_entity)
      auth_success(handler.user)
    else
      auth_failed
    end
  end

  # delete /logout
  def destroy
    deactivate_token if current_user

    redirect_to root_path
  end

  private

  def component_class
    Biovision::Components::UsersComponent
  end

  # @param [User] user
  def auth_success(user)
    create_token_for_user(user)

    from = param_from_request(:from)
    next_page = from =~ %r{\A/[^/]} ? from : root_path
    render json: { links: { next: next_page } }
  end

  def auth_failed
    response = { errors: [{ title: t('authentication.create.failed') }] }
    render json: response, status: :unauthorized
  end
end
