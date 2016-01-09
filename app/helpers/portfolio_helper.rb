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
end
