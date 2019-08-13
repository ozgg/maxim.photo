# frozen_string_literal: true

# Photo tag
#
# Attributes:
#   name [String]
#   photos_count [Integer]
#   slug [String]
class PhotoTag < ApplicationRecord
  include Checkable
  include RequiredUniqueName

  NAME_LIMIT = 30

  has_many :photo_photo_tags, dependent: :delete_all
  has_many :photos, through: :photo_photo_tags

  before_validation { self.name = name.to_s.squeeze }
  before_validation { self.slug = name.to_s.downcase }
  validates_length_of :name, maximum: NAME_LIMIT

  scope :list_for_administration, -> { ordered_by_name }

  def self.entity_parameters
    %i[name]
  end
end
