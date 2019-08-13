# frozen_string_literal: true

# Administrative part of photo_tags management
class Admin::PhotoTagsController < AdminController
  before_action :set_entity, except: :index

  # get /admin/photo_tags
  def index
    @collection = PhotoTag.list_for_administration
  end

  # get /admin/photo_tags/:id
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
    @entity = PhotoTag.find_by(id: params[:id])
    handle_http_404('Cannot find photo_tag') if @entity.nil?
  end
end
