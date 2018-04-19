class Album < ApplicationRecord
  include Toggleable
  include RequiredUniqueSlug

  PRIORITY_RANGE    = (1..999)
  TITLE_LIMIT       = 100
  SLUG_LIMIT        = 100
  SLUG_PATTERN      = /\A[a-z][-0-9a-z]*[0-9a-z]\z/i
  SLUG_PATTERN_HTML = '^[a-z][-0-9a-zA-Z]*[0-9a-zA-Z]$'
  META_LIMIT        = 250

  IMAGE_PREVIEW    = '80x80'
  IMAGE_PREVIEW_2X = '160x160'
  IMAGE_SMALL      = '320x320'
  IMAGE_MEDIUM     = '640x640'
  IMAGE_LARGE      = '1280x1280'

  toggleable :visible, :highlight

  has_one_attached :image

  after_initialize :set_next_priority
  before_validation :normalize_priority

  validates_presence_of :title
  validates_uniqueness_of :title
  validates_format_of :slug, with: SLUG_PATTERN
  validates_length_of :slug, maximum: SLUG_LIMIT
  validates_length_of :title, maximum: TITLE_LIMIT
  validates_length_of :image_alt_text, maximum: META_LIMIT

  scope :ordered_by_priority, -> { order('priority asc, title asc') }
  scope :visible, -> { where(visible: true) }
  scope :highlighted, -> { where(highlight: true) }
  scope :list_for_visitors, -> { visible.ordered_by_priority }
  scope :list_for_administration, -> { ordered_by_priority }

  # @param [Integer] page
  def self.page_for_administration(page = 1)
    list_for_administration.page(page)
  end

  # @param [Integer] page
  def self.page_for_visitors(page = 1)
    list_for_visitors.page(page)
  end

  def self.entity_parameters
    %i(visible highlight title slug image image_alt_text)
  end

  # @param [Integer] delta
  def change_priority(delta)
    new_priority = priority + delta
    criteria     = { priority: new_priority }
    adjacent     = self.class.find_by(criteria)
    if adjacent.is_a?(self.class) && (adjacent.id != id)
      adjacent.update!(priority: priority)
    end
    self.update(priority: new_priority)

    self.class.ordered_by_priority.map { |e| [e.id, e.priority] }.to_h
  end

  private

  def set_next_priority
    if id.nil? && priority == 1
      self.priority = self.class.maximum(:priority).to_i + 1
    end
  end

  def normalize_priority
    self.priority = PRIORITY_RANGE.first if priority < PRIORITY_RANGE.first
    self.priority = PRIORITY_RANGE.last if priority > PRIORITY_RANGE.last
  end
end
