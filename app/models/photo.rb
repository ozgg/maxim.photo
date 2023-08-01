# frozen_string_literal: true

# Photo
#
# Attributes:
#   album_id [Album], optional
#   created_at [DateTime]
#   description [Text], optional
#   image [SimpleImageUploader]
#   image_alt_text [string], optional
#   priority [integer]
#   title [string], optional
#   updated_at [DateTime]
#   uuid [UUID]
class Photo < ApplicationRecord
  include Checkable
  include HasUuid
  include NestedPriority

  DESCRIPTION_LIMIT = 5000
  META_LIMIT = 255
  TITLE_LIMIT = 140

  mount_uploader :image, PhotoUploader

  belongs_to :album, counter_cache: true, optional: true, touch: true
  belongs_to :story, optional: true
  has_many :photo_photo_tags, dependent: :destroy
  has_many :photo_tags, through: :photo_photo_tags

  validates_presence_of :image
  validates_length_of :description, maximum: DESCRIPTION_LIMIT
  validates_length_of :image_alt_text, maximum: META_LIMIT
  validates_length_of :title, maximum: TITLE_LIMIT

  scope :recent, -> { order(id: :desc) }
  scope :sequential, -> { order(:id) }
  scope :in_album, ->(v) { where(album: v) }
  scope :list_for_visitors, -> { ordered_by_priority }
  scope :list_for_administration, -> { ordered_by_priority }

  # @param [Integer] page
  def self.stream_page(page = 1)
    recent.page(page)
  end

  # @param [Photo] entity
  def self.siblings(entity)
    where(album_id: entity&.album_id)
  end

  def self.entity_parameters
    %i[album_id description image image_alt_text priority story_id title visible]
  end

  def self.creation_parameters
    entity_parameters
  end

  def title!
    title.blank? ? id : title
  end

  def featured?
    FeaturedPhoto.where(photo_id: id).exists?
  end

  # @param [PhotoTag] entity
  def photo_tag?(entity)
    photo_photo_tags.where(photo_tag: entity).exists?
  end

  # @param [PhotoTag] entity
  def add_photo_tag(entity)
    photo_photo_tags.create(photo_tag: entity)
  end

  # @param [PhotoTag] entity
  def remove_photo_tag(entity)
    photo_photo_tags.where(photo_tag: entity).destroy_all
  end
end
