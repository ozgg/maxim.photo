class AlbumsController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # get /albums
  def index
    @albums = Album.list_for_user current_user
  end

  # get /albums/new
  def new
    @album = Album.new
  end

  # post /albums
  def create
    @album = Album.new album_parameters
    if @album.save
      flash[:notice] = t('album.created')
      redirect_to @album
    else
      render :new
    end
  end

  # get /albums/:id
  def show
  end

  # get /albums/:id/edit
  def edit
  end

  # patch /albums/:id
  def update
    if @album.update(album_parameters)
      flash[:notice] = t('album.updated')
      redirect_to @album
    else
      render :edit
    end
  end

  # delete /albums/:id
  def destroy
    if @album.destroy
      flash[:notice] = t('album.deleted')
    end
    redirect_to albums_path
  end

  protected

  def set_album
    id = params[:id]
    if id.to_i.to_s == id
      @album = Album.find id.to_i
    else
      @album = Album.find_by slug: id
      redirect_to albums_path unless @album.is_a? Album
    end
  end

  def album_parameters
    allowed = [
        :image, :priority, :hidden, :slug,
        :name_ru, :name_en, :name_es, :description_ru, :description_en, :description_es
    ]
    params.require(:album).permit(allowed)
  end
end
