class Photo < ActiveRecord::Base
  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader

  scope :visible, -> { where(visible: true) }

  def adjacent
    {
        previous: Photo.visible.where('id < ?', self.id).order('id desc').first(4),
        next: Photo.visible.where('id > ?', self.id).order('id asc').first(4),
    }
  end
end
