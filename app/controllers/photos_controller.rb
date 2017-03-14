class PhotosController < ApplicationController
  before_action :restrict_access, except: [:index, :show]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /photos
  def index
    @collection = Photo.page_for_visitors(current_page)
  end

  # get /photos/new
  def new
    @entity = Photo.new
  end

  # post /photos
  def create
    @entity = Photo.new entity_parameters
    if @entity.save
      redirect_to admin_photo_path(@entity)
    else
      render :new, status: :bad_request
    end
  end

  # get /photos/:id
  def show
    @adjacent = @entity.adjacent
  end

  # get /photos/:id/edit
  def edit
  end

  # patch /photos/:id
  def update
    if @entity.update entity_parameters
      redirect_to admin_photo_path(@entity), notice: t('photos.update.success')
    else
      render :edit, status: :bad_request
    end
  end

  # delete /photos/:id
  def destroy
    if @entity.destroy
      flash[:notice] = t('photos.destroy.success')
    end
    redirect_to admin_photos_path
  end

  protected

  def restrict_access
    require_privilege :administrator
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
end
