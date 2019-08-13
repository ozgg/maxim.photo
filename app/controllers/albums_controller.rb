# frozen_string_literal: true

# Managing albums
class AlbumsController < ApplicationController
  before_action :restrict_access, except: %i[index show]
  before_action :set_entity, only: %i[edit update destroy]

  layout 'admin', except: %i[index show]

  # post /albums/check
  def check
    @entity = Album.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /albums
  def index
    @collection = Album.list_for_visitors
  end

  # get /albums/new
  def new
    @entity = Album.new
  end

  # post /albums
  def create
    @entity = Album.new(entity_parameters)
    if @entity.save
      form_processed_ok(admin_album_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /albums/:id-:slug
  def show
    @entity = Album.list_for_visitors.find_by(id: params[:id])
    handle_http_404('Cannot find album') if @entity.nil?
  end

  # get /albums/:id/edit
  def edit
  end

  # patch /albums/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_album_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /albums/:id
  def destroy
    flash[:notice] = t('albums.destroy.success') if @entity.destroy

    redirect_to(admin_albums_path)
  end

  protected

  def restrict_access
    component_restriction Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = Album.find_by(id: params[:id])
    handle_http_404('Cannot find album') if @entity.nil?
  end

  def entity_parameters
    params.require(:album).permit(Album.entity_parameters)
  end
end
