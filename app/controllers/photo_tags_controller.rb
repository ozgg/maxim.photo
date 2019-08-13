# frozen_string_literal: true

# Managing photo_tags
class PhotoTagsController < AdminController
  before_action :set_entity, only: %i[edit update destroy]

  # post /photo_tags/check
  def check
    @entity = PhotoTag.instance_for_check(params[:entity_id], entity_parameters)

    render 'shared/forms/check'
  end

  # get /photo_tags/new
  def new
    @entity = PhotoTag.new
  end

  # post /photo_tags
  def create
    @entity = PhotoTag.new(entity_parameters)
    if @entity.save
      form_processed_ok(admin_photo_tag_path(id: @entity.id))
    else
      form_processed_with_error(:new)
    end
  end

  # get /photo_tags/:id/edit
  def edit
  end

  # patch /photo_tags/:id
  def update
    if @entity.update(entity_parameters)
      form_processed_ok(admin_photo_tag_path(id: @entity.id))
    else
      form_processed_with_error(:edit)
    end
  end

  # delete /photo_tags/:id
  def destroy
    flash[:notice] = t('photo_tags.destroy.success') if @entity.destroy

    redirect_to(admin_photo_tags_path)
  end

  protected

  def restrict_access
    component_restriction Biovision::Components::PhotosComponent
  end

  def set_entity
    @entity = PhotoTag.find_by(id: params[:id])
    handle_http_404('Cannot find photo_tag') if @entity.nil?
  end

  def entity_parameters
    params.require(:photo_tag).permit(PhotoTag.entity_parameters)
  end
end
