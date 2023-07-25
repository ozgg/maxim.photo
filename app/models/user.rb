# frozen_string_literal: true

# User
#
# Attributes:
#   password_digest [string]
#   slug [string]
class User < ApplicationRecord
  include Biovision::RequiredUniqueSlug

  has_secure_password

  has_many :tokens, dependent: :delete_all
  has_many :login_attempts, dependent: :delete_all

  def self.[](login)
    find_by(slug: login)
  end

  def profile_name
    slug
  end
end
