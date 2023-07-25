# frozen_string_literal: true

module Biovision
  module Components
    module Users
      # Authentication part of users component
      module Authentication
        def authenticate(password, track)
          @password = password
          @track = track
          let_user_in?
        end

        private

        def let_user_in?
          return false if user.nil?

          too_many_attempts? ? (log_attempt && false) : try_password
        end

        def too_many_attempts?
          timeout = 5
          limit = 15
          LoginAttempt.owned_by(user).since(timeout.minutes.ago).count > limit
        end

        def log_attempt
          data = { password: @password }
          LoginAttempt.owned_by(user).create(data.merge(@track))
        end

        def try_password
          user.authenticate(@password) || (log_attempt && false)
        end
      end
    end
  end
end
