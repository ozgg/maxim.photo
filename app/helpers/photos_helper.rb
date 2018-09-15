module PhotosHelper
  # @param [Photo] entity
  # @param [String] entity
  def admin_photo_link(entity, text = entity.title)
    link_to(text, admin_photo_path(id: entity.id))
  end

  # @param [Album] entity
  # @param [String] text
  def admin_album_link(entity, text = entity.title)
    link_to(text, admin_album_path(id: entity.id))
  end

  # @param [Album] entity
  # @param [String] text
  # @param [Hash] options
  def album_link(entity, text = entity.title, options = {})
    link_to(text, portfolio_album_path(id: entity.id, slug: entity.slug), options)
  end

  # @param [Photo|Album] entity
  def photo_image_preview(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.preview_2x.url} 2x"
    image_tag(entity.image.preview.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Photo|Album] entity
  def photo_image_small(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.medium.url} 2x"
    image_tag(entity.image.small.url, alt: entity.image_alt_text, srcset: versions)
  end

  # @param [Photo|Album] entity
  def photo_image_medium(entity)
    return '' if entity.image.blank?
    versions = "#{entity.image.big.url} 2x"
    image_tag(entity.image.medium.url, alt: entity.image_alt_text, srcset: versions)
  end
end