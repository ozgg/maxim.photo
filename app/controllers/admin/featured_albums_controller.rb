# frozen_string_literal: true

# Handling featured albums
class Admin::FeaturedAlbumsController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity, except: %i[index create]

  # get /admin/featured_albums
  def index
    @collection = FeaturedAlbum.list_for_administration
  end

  # delete /admin/featured_albums/:id
  def destroy
    FeaturedAlbum.where(album_id: params[:id]).destroy_all

    head :no_content
  end

  # post /admin/featured_albums
  def create
    FeaturedAlbum.create(album_id: params[:id])

    head :no_content
  end

  private

  def component_class
    Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = FeaturedAlbum.find_by(id: params[:id])
    handle_http_404('Cannot find featured_album') if @entity.nil?
  end
end
