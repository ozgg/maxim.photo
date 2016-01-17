module PortfolioHelper
  # @param [Theme] theme
  # @param [String] text
  def link_to_theme(theme, text = nil)
    link_to text || theme.name, portfolio_theme_path(theme: theme.slug)
  end

  # @param [Album] album
  # @param [String] text
  def link_to_album(album, text = nil)
    link_to text || album.name, portfolio_album_path(theme: album.theme.slug, album: album.slug)
  end

  # @param [Photo] photo
  def link_to_photo(photo)
    source = photo.preview.blank? ? photo.image.big_square.url : photo.preview.big.url
    album  = photo.album.slug
    theme  = photo.album.theme.slug
    link_to image_tag(source, alt: photo.name), portfolio_photo_path(theme: theme, album: album, id: photo.id)
  end
end
