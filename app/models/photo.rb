class Photo < ApplicationRecord
  TITLE_LIMIT    = 50
  KEYWORDS_LIMIT = 250
  LEAD_LIMIT     = 250
  PER_PAGE       = 12

  mount_uploader :image, PhotoImageUploader

  validates_presence_of :title, :image
  validates_length_of :title, maximum: TITLE_LIMIT
  validates_length_of :lead, maximum: LEAD_LIMIT
  validates_length_of :keywords, maximum: KEYWORDS_LIMIT

  scope :recent, -> { order('id desc') }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    recent.page(page).per(PER_PAGE)
  end

  # @param [Integer] page
  def self.page_for_visitors(page = 1)
    recent.page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    %i(image title hazard_motion nudity keywords lead description shot_date)
  end
end
