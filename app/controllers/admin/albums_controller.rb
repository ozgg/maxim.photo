# frozen_string_literal: true

# Administrative part of albums management
class Admin::AlbumsController < AdminController
  include ToggleableEntity

  before_action :set_entity, except: :index

  # get /admin/albums
  def index
    @collection = Album.list_for_administration
  end

  # get /admin/albums/:id
  def show
  end

  private

  def component_slug
    Biovision::Components::PhotosComponent::SLUG
  end

  def restrict_access
    component_restriction Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = Album.find_by(id: params[:id])
    handle_http_404('Cannot find album') if @entity.nil?
  end
end
