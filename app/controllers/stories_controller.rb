# frozen_string_literal: true

# Managing stories
class StoriesController < ApplicationController
  before_action :restrict_access, except: %i[index show]
  before_action :set_entity, only: %i[edit update destroy show]

  layout 'admin', except: %i[index show]

  # post /stories/check
  def check
    @entity = Story.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /stories
  def index
    @collection = Story.page_for_visitors(current_page)
  end

  # get /stories/new
  def new
    @entity = Story.new
  end

  # post /stories
  def create
    @entity = Story.new(entity_parameters)
    if @entity.save
      form_processed_ok(admin_story_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /stories/:id-:slug
  def show
    @entity = Story.find_by(id: params[:id])
    handle_http_404('Cannot find story') if @entity.nil?
  end

  # get /stories/:id/edit
  def edit
  end

  # patch /stories/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_story_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /stories/:id
  def destroy
    flash[:notice] = t('stories.destroy.success') if @entity.destroy

    redirect_to(admin_stories_path)
  end

  protected

  def component_class
    Biovision::Components::PhotosComponent
  end

  def restrict_access
    error = 'Managing stories is not allowed'
    handle_http_401(error) unless component_handler.allow?
  end

  def set_entity
    @entity = Story.find_by(id: params[:id])
    handle_http_404('Cannot find story') if @entity.nil?
  end

  def entity_parameters
    params.require(:story).permit(Story.entity_parameters)
  end
end
