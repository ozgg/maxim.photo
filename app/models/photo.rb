# frozen_string_literal: true

# Photo
# 
# Attributes:
#   album_id [Album], optional
#   created_at [DateTime]
#   image [SimpleImageUploader]
#   image_alt_text [string], optional
#   meta_description [string], optional
#   meta_keywords [string], optional
#   meta_title [string], optional
#   priority [integer]
#   title [string], optional
#   updated_at [DateTime]
#   visible [boolean]
class Photo < ApplicationRecord
  include Checkable
  include MetaTexts
  include NestedPriority
  include Toggleable

  META_LIMIT = 255
  TITLE_LIMIT = 140

  toggleable :visible

  mount_uploader :image, SimpleImageUploader

  belongs_to :album, counter_cache: true, optional: true
  has_many :photo_photo_tags, dependent: :destroy
  has_many :photo_tags, through: :photo_photo_tags

  validates_length_of :image_alt_text, maximum: META_LIMIT
  validates_length_of :title, maximum: TITLE_LIMIT

  scope :visible, -> { where(visible: true) }
  scope :recent, -> { order('id desc') }
  scope :in_album, ->(v) { where(album: v) }
  scope :list_for_visitors, -> { visible }
  scope :list_for_administration, -> { ordered_by_priority }

  # @param [Photo] entity
  def self.siblings(entity)
    where(album_id: entity&.album_id)
  end

  def self.entity_parameters
    meta_text_fields + %i[image image_alt_text priority title visible]
  end

  def self.creation_parameters
    entity_parameters + %i[album_id]
  end

  def title!
    title.blank? ? id : title
  end
end
