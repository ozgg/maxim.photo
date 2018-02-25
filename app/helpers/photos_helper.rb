module PhotosHelper
  # @param [Photo] entity
  def admin_photo_link(entity)
    link_to(entity.caption, admin_photo_path(entity.id))
  end

  # @param [Album] entity
  def admin_album_link(entity)
    link_to(entity.title, admin_album_path(entity.id))
  end

  # @param [Album] entity
  def album_image_preview(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.preview_2x.url} 2x"
    image_tag(entity.image.preview.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Album] entity
  def album_image_small(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.medium.url} 2x"
    image_tag(entity.image.small.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Album] entity
  def album_image_medium(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.large.url} 2x"
    image_tag(entity.image.medium.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Photo] entity
  def photo_image_preview(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.preview_2x.url} 2x"
    image_tag(entity.image.preview.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Photo] entity
  def photo_image_medium(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.medium_2x.url} 2x"
    image_tag(entity.image.medium.url, alt: entity.image_alt_text, srcset: versions)
  end
end
