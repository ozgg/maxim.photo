module AlbumsHelper
  def album_for_select
    Album.order('theme_id asc, name asc').map { |album| [album.long_name, album.id] }
  end
end
