class Photo < ActiveRecord::Base
  validates_presence_of :name, :image

  mount_uploader :image, ImageUploader

  scope :visible, -> { where(visible: true) }
end
