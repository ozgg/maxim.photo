class PhotosController < ApplicationController
  before_action :restrict_anonymous_access, except: [:index, :show]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @collection = Photo.visible.order('id desc').page(current_page).per(9)
    else
      @collection = Photo.visible.order('id desc').page(current_page).per(9)
    end
  end

  def new
    @entity = Photo.new
  end

  def create
    @entity = Photo.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
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
    params.require(:photo).permit(:visible, :name, :image, :description)
  end
end
