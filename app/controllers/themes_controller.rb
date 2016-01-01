class ThemesController < ApplicationController
  before_action :restrict_anonymous_access, except: [:index, :show]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Theme.list_for_user current_user.is_a?(User)
  end

  def new
    @entity = Theme.new
  end

  def create
    @entity = Theme.new entity_parameters
    @entity.save ? redirect_to(@entity) : render(:new)
  end

  def update
    @entity.update(entity_parameters) ? redirect_to(@entity) : render(:edit)
  end

  def destroy
    @entity.destroy
    redirect_to themes_path
  end

  protected

  def set_entity
    @entity = Theme.find params[:id]
  end

  def entity_parameters
    params.require(:theme).permit(:visible, :name, :image, :description)
  end
end
