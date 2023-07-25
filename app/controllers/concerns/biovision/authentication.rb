# frozen_string_literal: true

module Biovision
  # Adds methods for user authentication
  module Authentication
    extend ActiveSupport::Concern

    def redirect_authenticated_user
      redirect_to root_path unless current_user.nil?
    end

    # @param [User] user
    def create_token_for_user(user)
      token = user.tokens.create!(tracking_for_entity)

      cookies['token'] = cookie_data(token.cookie_pair)
    end

    def deactivate_token
      token = Token.find_by(token: cookies['token'].split(':').last)
      token&.update(active: false)
      cookies.delete 'token', domain: :all
    end

    # @param [String] value
    def cookie_data(value)
      {
        value: value,
        expires: 1.year.from_now,
        domain: :all,
        httponly: true
      }
    end
  end
end
