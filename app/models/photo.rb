class Photo < ActiveRecord::Base
  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader
  mount_uploader :preview, PreviewUploader

  scope :visible, -> { where visible: true }

  def adjacent
    {
        previous: Photo.visible.where('id < ?', self.id).order('id desc').first,
        next: Photo.visible.where('id > ?', self.id).order('id asc').first,
    }
  end
end
