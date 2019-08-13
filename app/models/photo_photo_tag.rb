# frozen_string_literal: true

# Link between photo and photo_tag
#
# Attributes:
#   photo_id [Photo]
#   photo_tag_id [PhotoTag]
class PhotoPhotoTag < ApplicationRecord
  belongs_to :photo
  belongs_to :photo_tag, counter_cache: :photos_count

  validates_uniqueness_of :photo_tag_id, scope: :photo_id
end
