# frozen_string_literal: true

# Managing photos
class PhotosController < ApplicationController
  before_action :restrict_access, except: %i[index show]
  before_action :set_entity, only: %i[edit update destroy]

  layout 'admin', except: %i[index show stream]

  # post /photos/check
  def check
    @entity = Photo.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /photos
  def index
    @collection = Photo.list_for_visitors
  end

  # get /photos/new
  def new
    @entity = Photo.new
  end

  # post /photos
  def create
    @entity = Photo.new(creation_parameters)
    if @entity.save
      form_processed_ok(next_path)
    else
      form_processed_with_error(:new)
    end
  end

  # get /photos/:id-:slug
  def show
    @entity = Photo.list_for_visitors.find_by(id: params[:id])
    handle_http_404('Cannot find photo') if @entity.nil?
  end

  # get /photos/:id/edit
  def edit
  end

  # patch /photos/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_photo_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /photos/:id
  def destroy
    flash[:notice] = t('photos.destroy.success') if @entity.destroy

    redirect_to(admin_photos_path)
  end

  # get /stream
  def stream
    @collection = Photo.stream_page(current_page)
  end

  protected

  def component_class
    Biovision::Components::PhotosComponent
  end

  def restrict_access
    error = 'Managing photos is not allowed'
    handle_http_401(error) unless component_handler.allow?
  end

  def set_entity
    @entity = Photo.find_by(id: params[:id])
    handle_http_404('Cannot find photo') if @entity.nil?
  end

  def entity_parameters
    params.require(:photo).permit(Photo.entity_parameters)
  end

  def creation_parameters
    params.require(:photo).permit(Photo.creation_parameters)
  end

  def next_path
    if @entity.story.present?
      admin_story_path(id: @entity.story_id)
    elsif @entity.album.present?
      admin_album_path(id: @entity.album_id)
    else
      admin_photo_path(id: @entity.id)
    end
  end
end
