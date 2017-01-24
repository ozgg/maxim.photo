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

  # @param [Photo] photo
  def photo_image_preview(photo)
    versions = "#{photo.image.big.url} 2x"
    image_tag(photo.image.medium.url, alt: photo.title, srcset: versions)
  end

  # @param [Photo] photo
  def photo_image_full(photo)
    versions = "#{photo.image.url} 2x"
    image_tag(photo.image.big.url, alt: photo.title, srcset: versions)
  end

  # @param [Photo] photo
  def prepare_photo_description(photo)
    simple_format(photo.description)
  end
end
