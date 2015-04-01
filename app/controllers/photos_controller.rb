class PhotosController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      @photos = Photo.order('id desc').page(params[:page] || 1).per(5)
    else
      redirect_to root_path
    end
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_parameters)
    if @photo.save
      set_categories
      flash[:notice] = t('photo.created')
      redirect_to @photo
    else
      render :new
    end
  end

  def show

  end

  def edit

  end

  def update
    if @photo.update(photo_parameters)
      set_categories
      flash[:notice] = t('photo.updated')
      redirect_to @photo
    else
      render :edit
    end
  end

  def destroy
    if @photo.destroy
      flash[:notice] = t('photo.deleted')
    end
    redirect_to photos_path
  end

  protected

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_parameters
    allowed = [
        :album_id, :image, :name_ru, :name_en, :name_es,
        :description_ru, :description_en, :description_es
    ]
    params.require(:photo).permit(allowed)
  end

  def set_categories
    if params[:photo][:category_ids]
      @photo.category_ids = params[:photo][:category_ids]
    end
  end
end
