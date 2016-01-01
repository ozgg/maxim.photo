class Theme < ActiveRecord::Base
  include Visibility

  validates_presence_of :name, :priority
  validates_uniqueness_of :name

  mount_uploader :preview, PreviewUploader

  after_initialize :set_next_priority

  def self.list_for_user(show_hidden = false)
    self.visibility(show_hidden ? nil : true).order('name asc')
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
