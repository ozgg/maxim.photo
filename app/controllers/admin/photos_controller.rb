# frozen_string_literal: true

# Administrative part of photos management
class Admin::PhotosController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity, except: :index

  # get /admin/photos
  def index
    @collection = Photo.recent.page(current_page)
  end

  # get /admin/photos/:id
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
    @entity = Photo.find_by(id: params[:id])
    handle_http_404('Cannot find photo') if @entity.nil?
  end
end
