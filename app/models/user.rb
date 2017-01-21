class User < ApplicationRecord
  has_secure_password

  validates_presence_of :slug
  validates_uniqueness_of :slug
end
