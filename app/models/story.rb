# frozen_string_literal: true

# Photo story
#
# Attributes:
#   date [date]
#   description [string]
#   image [SimpleImageUploader], optional
#   image_alt_text [string], optional
#   name [string]
#   slug [string]
class Story < ApplicationRecord
  DESCRIPTION_LIMIT = 65_535
  META_LIMIT = 255
  NAME_LIMIT = 100
  SLUG_LIMIT = 100
  SLUG_PATTERN = /\A[a-z0-9][-_a-z0-9]*[a-z0-9]\z/i.freeze
  SLUG_PATTERN_HTML = '^[a-zA-Z0-9][-_a-zA-Z0-9]*[a-zA-Z0-9]$'

  mount_uploader :image, PhotoUploader

  has_many :photos, dependent: :nullify

  before_validation :normalize_slug
  validates_presence_of :image
  validates_length_of :description, maximum: DESCRIPTION_LIMIT
  validates_length_of :image_alt_text, maximum: META_LIMIT
  validates_length_of :name, maximum: NAME_LIMIT
  validates_length_of :slug, maximum: SLUG_LIMIT
  validates_format_of :slug, with: SLUG_PATTERN

  scope :recent, -> { order(date: :desc) }
  scope :list_for_visitors, -> { recent }
  scope :list_for_administration, -> { recent }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  # @param [Integer] page
  def self.page_for_visitors(page = 1)
    list_for_visitors.page(page)
  end

  def self.entity_parameters
    %i[date description image image_alt_text name slug]
  end

  def url
    "/stories/#{id}-#{slug}"
  end

  private

  def normalize_slug
    self.slug = Canonizer.transliterate(name) if slug.blank?
    self.slug = slug.to_s.downcase[0..SLUG_LIMIT]
  end
end
