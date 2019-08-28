# frozen_string_literal: true

# Handling featured photos
class Admin::FeaturedPhotosController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity, except: %i[index create]

  # get /admin/featured_photos
  def index
    @collection = FeaturedPhoto.list_for_administration
  end

  # delete /admin/featured_photos/:id
  def destroy
    FeaturedPhoto.where(photo_id: params[:id]).destroy_all

    head :no_content
  end

  # post /admin/featured_photos
  def create
    FeaturedPhoto.create(photo_id: params[:id])

    head :no_content
  end

  private

  def set_entity
    @entity = FeaturedPhoto.find_by(id: params[:id])
    handle_http_404('Cannot find featured_photo') if @entity.nil?
  end
end
