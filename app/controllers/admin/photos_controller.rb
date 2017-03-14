class Admin::PhotosController < AdminController
  before_action :set_entity, except: [:index]

  # get /admin/photos
  def index
    @collection = Photo.page_for_administration(current_page)
  end

  # get /admin/photos/:id
  def show
  end

  private

  def set_entity
    @entity = Photo.find_by(id: params[:id])
    if @entity.nil?
      handle_http_404('Cannot find photo')
    end
  end
end
