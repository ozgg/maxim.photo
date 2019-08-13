# frozen_string_literal: true

# Album
# 
# Attributes:
#   created_at [DateTime]
#   description [string], optional
#   image [SimpleImageUploader], optional
#   image_alt_text [string], optional
#   meta_description [string], optional
#   meta_keywords [string], optional
#   meta_title [string], optional
#   name [string]
#   photos_count [integer]
#   slug [string]
#   visible [boolean]
class Album < ApplicationRecord
  include Checkable
  include MetaTexts
  include RequiredUniqueName
  include RequiredUniqueSlug
  include Toggleable

  DESCRIPTION_LIMIT = 255
  META_LIMIT = 255
  NAME_LIMIT = 50
  SLUG_LIMIT = 50
  SLUG_PATTERN = /\A[a-z0-9][-_a-z0-9]*[a-z0-9]\z/i.freeze
  SLUG_PATTERN_HTML = '^[a-zA-Z0-9][-_a-zA-Z0-9]*[a-zA-Z0-9]$'

  toggleable :visible

  mount_uploader :image, SimpleImageUploader

  has_many :photos, dependent: :destroy

  before_validation :normalize_slug
  validates_length_of :description, maximum: DESCRIPTION_LIMIT
  validates_length_of :image_alt_text, maximum: META_LIMIT
  validates_length_of :name, maximum: NAME_LIMIT
  validates_length_of :slug, maximum: SLUG_LIMIT
  validates_format_of :slug, with: SLUG_PATTERN

  scope :visible, -> { where(visible: true) }
  scope :recent, -> { order('updated_at desc') }
  scope :list_for_visitors, -> { visible.recent }
  scope :list_for_administration, -> { ordered_by_name }

  def self.entity_parameters
    meta_text_fields + %i[description image image_alt_text name slug visible]
  end

  private

  def normalize_slug
    self.slug = Canonizer.transliterate(name) if slug.blank?
    self.slug = slug.to_s.downcase[0..SLUG_LIMIT]
  end
end
