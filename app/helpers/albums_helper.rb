module AlbumsHelper

  # Link to album with slug as id
  #
  # @param [Category] album
  # @return [String]
  def album_by_slug(album)
    link_to album.name(I18n.locale), album_path(id: album.slug)
  end
end
