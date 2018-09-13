class PhotosController < AdminController
  before_action :set_entity, only: [:edit, :update, :destroy]

  # get /photos/new
  def new
    @entity = Photo.new
  end

  # post /photos
  def create
    @entity = Photo.new(creation_parameters)
    if @entity.save
      form_processed_ok(admin_photo_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /photos/:id/edit
  def edit
  end

  # patch /photos/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_photo_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /photos/:id
  def destroy
    if @entity.destroy
      flash[:notice] = t('photos.destroy.success')
    end
    redirect_to(admin_photos_path)
  end

  protected

  def restrict_access
    require_privilege :photo_manager
  end

  def set_entity
    @entity = Photo.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find photo')
    end
  end

  def entity_parameters
    params.require(:photo).permit(Photo.entity_parameters)
  end

  def creation_parameters
    params.require(:photo).permit(Photo.creation_parameters)
  end
end
