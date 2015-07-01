module PhotoHelper
  def link_to_photo(photo, options = {})
    link_to image_tag(photo.image.small_square.url, alt: photo.name), photo, options
  end
end
