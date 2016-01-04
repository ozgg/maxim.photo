class Album < ActiveRecord::Base
  belongs_to :theme

  validates_presence_of :name, :slug, :theme_id
  validates_uniqueness_of :slug, scope: [:theme_id]

  mount_uploader :image, PreviewUploader

  scope :ordered_by_name, -> { order 'name asc' }

  def self.list_for_administration
    self.ordered_by_name
  end

  def self.entity_parameters
    %i(theme_id name slug image)
  end

  def long_name
    "#{theme.name} — #{name}"
  end
end
