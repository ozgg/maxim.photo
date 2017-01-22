module PhotosHelper
  # @param [Photo] photo
  def admin_photo_link(photo)
    link_to(photo.title, admin_photo_path(photo.id))
  end

  # @param [Photo] photo
  def photo_image_thumbnail(photo)
    unless photo.image.blank?
      versions = "#{photo.image.thumbnail_2x.url} 2x"
      image_tag(photo.image.thumbnail.url, alt: photo.title, srcset: versions)
    end
  end
end
