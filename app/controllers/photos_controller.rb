class PhotosController < ApplicationController
  before_action :restrict_anonymous_access, except: [:index, :show]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Photo.page_for_administration(current_page)
  end

  def new
    @entity = Photo.new
  end

  def create
    @entity = Photo.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
  end

  def show
    unless current_user.is_a? User
      redirect_to portfolio_photo_path(theme: @entity.theme.slug, album: @entity.album.slug, id: @entity.id)
    end
  end

  def update
    @entity.update(entity_parameters) ? redirect_to(@entity) : render(:edit)
  end

  def destroy
    @entity.destroy
    redirect_to photos_path
  end

  protected

  def set_entity
    @entity = Photo.find params[:id]
  end

  def entity_parameters
    params.require(:photo).permit(Photo.entity_parameters)
  end
end
