class AlbumsController < ApplicationController
  before_action :restrict_anonymous_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /albums
  def index
    @collection = Album.list_for_administration
  end

  # get /albums/new
  def new
    @entity = Album.new
  end

  # post /albums
  def create
    @entity = Album.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
  end

  # patch /albums/:id
  def update
    @entity.update(entity_parameters) ? redirect_to(@entity) : render(:edit)
  end

  # delete /albums/:id
  def destroy
    @entity.destroy
    redirect_to albums_path
  end

  protected

  def set_entity
    @entity = Album.find params[:id]
  end

  def entity_parameters
    params.require(:album).permit(Album.entity_parameters)
  end
end
