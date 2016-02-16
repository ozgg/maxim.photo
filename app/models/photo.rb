class Photo < ActiveRecord::Base
  belongs_to :album

  validates_presence_of :name, :image, :album_id

  mount_uploader :image, ImageUploader
  mount_uploader :preview, PreviewUploader

  scope :visible, -> { where visible: true }
  scope :ordered_by_id, -> { order 'id asc' }

  PER_PAGE = 9

  def self.recent_photos
    order('id desc').first(3)
  end

  def self.page_for_administration(page)
    order('id desc').page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    %i(album_id visible image preview name description)
  end

  def theme
    album.theme
  end
end
