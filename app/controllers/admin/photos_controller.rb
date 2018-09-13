class Admin::PhotosController < AdminController
  include ToggleableEntity
  include EntityPriority

  before_action :set_entity

  # get /admin/photos/:id
  def show
  end

  private

  def restrict_access
    require_privilege :photo_manager
  end

  def set_entity
    @entity = Photo.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404("Cannot find photo #{params[:id]}")
    end
  end
end
