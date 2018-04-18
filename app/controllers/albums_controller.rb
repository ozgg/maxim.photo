class AlbumsController < AdminController
  # get /albums/new
  def new
    @entity = Album.new
  end

  # post /albums
  def create
    @entity = Album.new(entity_parameters)
    if @entity.save
      form_processed_ok(admin_album_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /albums/:id/edit
  def edit
  end

  # patch /albums/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_album_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /albums/:id
  def destroy
    if @entity.destroy
      flash[:notice] = t('albums.destroy.success')
    end
    redirect_to(admin_albums_path)
  end

  protected

  def restrict_access
    require_privilege :photo_manager
  end

  def set_entity
    @entity = Album.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find album')
    end
  end

  def entity_parameters
    params.require(:album).permit(Album.entity_parameters)
  end
end
