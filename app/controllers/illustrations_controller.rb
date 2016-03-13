class IllustrationsController < ApplicationController
  before_action :restrict_anonymous_access
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /illustrations
  def index
    @collection = Illustration.page_for_administration current_page
  end

  # get /illustrations/new
  def new
    @entity = Illustration.new
  end

  # illustration /illustrations
  def create
    @entity = Illustration.new entity_parameters
    if @entity.save
      @entity.tags_string = params[:tags_string].to_s
      redirect_to @entity
    else
      render :new
    end
  end

  # get /illustrations/:id
  def show
  end

  # patch /illustrations/:id
  def update
    if @entity.update(entity_parameters)
      @entity.tags_string = params[:tags_string].to_s
      redirect_to @entity
    else
      render :edit
    end
  end

  # delete /illustrations/:id
  def destroy
    @entity.destroy
    redirect_to illustrations_path
  end

  protected

  def set_entity
    @entity = Illustration.find params[:id]
  end

  def entity_parameters
    params.require(:illustration).permit(Illustration.entity_parameters)
  end
end
