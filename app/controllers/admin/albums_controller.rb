class Admin::AlbumsController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity, except: [:index]

  # get /admin/albums
  def index
    @collection = Album.list_for_administration
  end

  # get /admin/albums/:id
  def show
  end

  # get /admin/albums/:id/photos
  def photos
    @collection = @entity.photos.list_for_administration
  end

  private

  def restrict_access
    require_privilege :photo_manager
  end

  def set_entity
    @entity = Album.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404("Cannot find album #{params[:id]}")
    end
  end
end
