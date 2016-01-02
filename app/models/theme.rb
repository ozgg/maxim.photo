class Theme < ActiveRecord::Base
  include Visibility

  has_many :albums

  validates_presence_of :name, :slug, :priority
  validates_uniqueness_of :slug

  mount_uploader :preview, PreviewUploader

  scope :ordered_by_name, -> { order 'name asc' }

  after_initialize :set_next_priority

  def self.list_for_administration
    self.ordered_by_name.all
  end

  def self.list_for_user(show_hidden = false)
    self.only_visible(!show_hidden).ordered_by_name
  end

  def self.entity_parameters
    [:name, :preview, :visible, :priority]
  end

  private

  def set_next_priority
    if self.id.nil?
      self.priority = Theme.maximum(:priority).to_i + 1
    end
  end
end
