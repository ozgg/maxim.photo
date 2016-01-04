class Photo < ActiveRecord::Base
  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader
  mount_uploader :preview, PreviewUploader

  scope :visible, -> { where visible: true }

  PER_PAGE = 9

  def self.page_for_administration(page)
    order('id desc').page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    %i(album_id visible image preview name description)
  end

  def adjacent
    {
        previous: Photo.visible.where('id < ?', self.id).order('id desc').first,
        next: Photo.visible.where('id > ?', self.id).order('id asc').first,
    }
  end
end
