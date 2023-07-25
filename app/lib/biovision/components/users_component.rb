# frozen_string_literal: true

module Biovision
  module Components
    # Handling users
    class UsersComponent < BaseComponent
      include Users::Authentication

      def self.dependent_models
        [User, Token, LoginAttempt]
      end
    end
  end
end
