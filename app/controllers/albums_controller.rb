class AlbumsController < ApplicationController
  before_action :restrict_access, except: [:index, :show]
  before_action :set_entity, only: [:edit, :update, :destroy]

  layout 'admin', only: [:new, :edit]

  # get /albums
  def index
    @collection = Album.page_for_visitors(current_page)
  end

  # get /albums/new
  def new
    @entity = Album.new
  end

  # post /albums
  def create
    @entity = Album.new(entity_parameters)
    if @entity.save
      next_page = admin_album_path(@entity.id)
      respond_to do |format|
        format.html { redirect_to next_page }
        format.js { render js: "document.location.href = '#{next_page}'" }
      end
    else
      render :new, status: :bad_request
    end
  end

  # get /albums/:id
  def show
    @entity = Album.visible.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404("Cannot find album #{params[:id]}")
    end
  end

  # get /albums/:id/edit
  def edit
  end

  # patch /albums/:id
  def update
    if @entity.update(entity_parameters)
      next_page = admin_album_path(@entity.id)
      respond_to do |format|
        format.html { redirect_to next_page }
        format.js { render js: "document.location.href = '#{next_page}'" }
      end
    else
      render :edit, status: :bad_request
    end
  end

  # delete /albums/:id
  def destroy
    if @entity.destroy
      flash[:notice] = t('albums.destroy.success')
    end
    redirect_to admin_albums_path
  end

  private

  def set_entity
    @entity = Album.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find album')
    end
  end

  def restrict_access
    require_privilege :photo_manager
  end

  def entity_parameters
    params.require(:album).permit(Album.entity_parameters)
  end
end
