class Photo < ApplicationRecord
  mount_uploader :image, PhotoImageUploader
end
