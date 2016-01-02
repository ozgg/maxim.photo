class ThemesController < ApplicationController
  before_action :restrict_anonymous_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /themes
  def index
    @collection = Theme.list_for_administration
  end

  # get /themes/new
  def new
    @entity = Theme.new
  end

  # post /themes
  def create
    @entity = Theme.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
  end

  # patch /themes/:id
  def update
    @entity.update(entity_parameters) ? redirect_to(@entity) : render(:edit)
  end

  # delete /themes/:id
  def destroy
    @entity.destroy
    redirect_to themes_path
  end

  protected

  def set_entity
    @entity = Theme.find params[:id]
  end

  def entity_parameters
    params.require(:theme).permit(Theme.entity_parameters)
  end
end
