class Album < ActiveRecord::Base
  belongs_to :theme

  validates_presence_of :name, :slug, :priority, :theme_id
  validates_uniqueness_of :slug, scope: [:theme_id]

  mount_uploader :image, PreviewUploader

  scope :ordered_by_name, -> { order 'name asc' }

  def self.list_for_view
    self.ordered_by_name
  end
end