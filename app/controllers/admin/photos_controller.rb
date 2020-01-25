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

  # put /admin/photos/:id/tags/:tag_id
  def add_tag
    @entity.add_photo_tag(PhotoTag.find_by(id: params[:tag_id]))

    head :no_content
  end

  # delete /admin/photos/:id/tags/:tag_id
  def remove_tag
    @entity.remove_photo_tag(PhotoTag.find_by(id: params[:tag_id]))

    head :no_content
  end

  private

  def component_class
    Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = Photo.find_by(id: params[:id])
    handle_http_404('Cannot find photo') if @entity.nil?
  end
end
