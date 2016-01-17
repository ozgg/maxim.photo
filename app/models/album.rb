class Album < ActiveRecord::Base
  belongs_to :theme
  has_many :photos

  validates_presence_of :name, :slug, :theme_id
  validates_uniqueness_of :slug, scope: [:theme_id]

  mount_uploader :image, PreviewUploader

  scope :ordered_by_name, -> { order 'name asc' }

  def self.list_for_administration
    self.ordered_by_name
  end

  def self.list_for_visitor
    self.order('id asc')
  end

  def self.entity_parameters
    %i(theme_id name slug image)
  end

  def photos_for_portfolio
    photos.visible.ordered_by_id
  end

  def long_name
    "#{theme.name} — #{name}"
  end
end
