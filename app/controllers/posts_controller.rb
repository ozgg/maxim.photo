class PostsController < ApplicationController
  before_action :restrict_anonymous_access, except: [:index, :show]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  def index
    @collection = Post.page_for_user(current_page)
  end

  def new
    @entity = Post.new
  end

  def create
    @entity = Post.new entity_parameters
    if @entity.save
      @entity.tags_string = params[:tags_string].to_s
      redirect_to @entity
    else
      render :new
    end
  end

  def show
  end

  def update
    if @entity.update(entity_parameters)
      @entity.tags_string = params[:tags_string].to_s
      redirect_to @entity
    else
      render :edit
    end
  end

  def destroy
    @entity.destroy
    redirect_to posts_path
  end

  protected

  def set_entity
    @entity = Post.find params[:id]
  end

  def entity_parameters
    params.require(:post).permit(Post.entity_parameters)
  end
end
