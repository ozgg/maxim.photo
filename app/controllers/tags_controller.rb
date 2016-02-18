class TagsController < ApplicationController
  before_action :restrict_anonymous_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /tags
  def index
    @collection = Tag.list_for_administration
  end

  # get /tags/new
  def new
    @entity = Tag.new
  end

  # post /tags
  def create
    @entity = Tag.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
  end

  # patch /tags/:id
  def update
    if @entity.update entity_parameters
      redirect_to @entity
    else
      render(:edit)
    end
  end

  # delete /tags/:id
  def destroy
    @entity.destroy
    redirect_to tags_path
  end

  protected

  def set_entity
    @entity = Tag.find params[:id]
  end

  def entity_parameters
    params.require(:tag).permit(Tag.entity_parameters)
  end
end
