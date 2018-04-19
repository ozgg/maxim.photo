module PhotosHelper
  # @param [Photo] entity
  def admin_photo_link(entity)
    link_to(entity.caption, admin_photo_path(id: entity.id))
  end

  # @param [Album] entity
  def admin_album_link(entity)
    link_to(entity.title, admin_album_path(id: entity.id))
  end

  # @param [Photo] entity
  def photo_image_preview(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.preview_2x.url} 2x"
    image_tag(entity.image.preview.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Album] entity
  def album_image_preview(entity)
    return '' unless entity.image.attached?
    versions = "#{url_for(entity.image.variant(resize: Album::IMAGE_PREVIEW_2X))} 2x"
    image_tag(entity.image.variant(resize: Album::IMAGE_PREVIEW), alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Photo] entity
  def photo_image_medium(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.medium_2x.url} 2x"
    image_tag(entity.image.medium.url, alt: entity.name, srcset: versions)
  end

  # @param [Album] entity
  def album_image_medium(entity)
    return '' unless entity.image.attached?
    versions = "#{url_for(entity.image.variant(resize: Album::IMAGE_LARGE))} 2x"
    image_tag(entity.image.variant(resize: Album::IMAGE_MEDIUM), alt: entity.image_alt_text, srcset: versions)
  end
end