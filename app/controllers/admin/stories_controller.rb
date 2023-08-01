# frozen_string_literal: true

# Administrative part of stories management
class Admin::StoriesController < AdminController
  before_action :set_entity, except: :index

  # get /admin/stories
  def index
    @collection = Story.page_for_administration(current_page)
  end

  # get /admin/stories/:id
  def show
  end

  private

  def component_class
    Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = Story.find_by(id: params[:id])
    handle_http_404('Cannot find story') if @entity.nil?
  end
end
