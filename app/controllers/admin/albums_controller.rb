class Admin::AlbumsController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity, except: [:index]

  # get /admin/album
  def index
    @collection = Album.page_for_administration(current_page)
  end

  # get /admin/albums/:id
  def show
  end

  private

  def restrict_access
    require_privilege :photo_manager
  end

  def set_entity
    @entity = Album.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find album')
    end
  end
end
