class Photo < ApplicationRecord
  include Toggleable

  PRIORITY_RANGE = (1..999)
  TITLE_LIMIT    = 100
  META_LIMIT     = 250

  toggleable :visible

  mount_uploader :image, PhotoImageUploader

  belongs_to :album, counter_cache: true

  after_initialize :set_next_priority
  before_validation :normalize_priority

  validates_presence_of :title

  scope :ordered_by_priority, -> { order('priority asc, title asc') }
  scope :siblings, -> (entity) { where(album: entity.album) }
  scope :visible, -> { where(visible: true) }
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
    meta_data = %i[image_alt_text meta_description meta_keywords meta_title]
    main_data = %i[image priority title visible]

    main_data + meta_data
  end

  def self.creation_parameters
    entity_parameters + %i[album_id]
  end

  # @param [Integer] delta
  def change_priority(delta)
    new_priority = priority + delta
    criteria     = { priority: new_priority }
    adjacent     = self.class.siblings(self).find_by(criteria)
    if adjacent.is_a?(self.class) && (adjacent.id != id)
      adjacent.update!(priority: priority)
    end
    self.update(priority: new_priority)

    self.class.siblings(self).ordered_by_priority.map { |e| [e.id, e.priority] }.to_h
  end

  private

  def set_next_priority
    if id.nil? && priority == 1
      self.priority = self.class.siblings(self).maximum(:priority).to_i + 1
    end
  end

  def normalize_priority
    self.priority = PRIORITY_RANGE.first if priority < PRIORITY_RANGE.first
    self.priority = PRIORITY_RANGE.last if priority > PRIORITY_RANGE.last
  end
end
