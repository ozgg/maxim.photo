# frozen_string_literal: true

# Album
#
# Attributes:
#   created_at [DateTime]
#   date [Date], optional
#   description [string], optional
#   image [SimpleImageUploader], optional
#   image_alt_text [string], optional
#   name [string]
#   photos_count [integer]
#   slug [string]
#   updated_at [DateTime]
class Album < ApplicationRecord
  include Checkable
  include HasUuid
  include RequiredUniqueName
  include RequiredUniqueSlug

  DESCRIPTION_LIMIT = 255
  META_LIMIT = 255
  NAME_LIMIT = 75
  SLUG_LIMIT = 75
  SLUG_PATTERN = /\A[a-z0-9][-_a-z0-9]*[a-z0-9]\z/i.freeze
  SLUG_PATTERN_HTML = '^[a-zA-Z0-9][-_a-zA-Z0-9]*[a-zA-Z0-9]$'

  mount_uploader :image, PhotoUploader

  has_many :photos, dependent: :destroy
  has_many :featured_albums, dependent: :delete_all

  before_validation :normalize_slug
  validates_presence_of :image
  validates_length_of :description, maximum: DESCRIPTION_LIMIT
  validates_length_of :image_alt_text, maximum: META_LIMIT
  validates_length_of :name, maximum: NAME_LIMIT
  validates_length_of :slug, maximum: SLUG_LIMIT
  validates_format_of :slug, with: SLUG_PATTERN

  scope :recent, -> { order(updated_at: :desc) }
  scope :list_for_visitors, -> { recent }
  scope :list_for_administration, -> { recent }

  def self.entity_parameters
    %i[date description image image_alt_text name slug]
  end

  def url
    "/albums/#{id}-#{slug}"
  end

  def text_for_link
    date.nil? ? name : "#{name} (#{date})"
  end

  private

  def normalize_slug
    self.slug = Canonizer.transliterate(name) if slug.blank?
    self.slug = slug.to_s.downcase[0..SLUG_LIMIT]
  end
end
