class PostsController < ApplicationController
  before_action :restrict_anonymous_access, except: [:index, :show, :tagged]
  before_action :set_entity, only: [:show, :edit, :update, :destroy]

  # get /posts
  def index
    @collection = Post.page_for_user(current_page)
  end

  # get /posts/new
  def new
    @entity = Post.new
  end

  # post /posts
  def create
    @entity = Post.new entity_parameters
    if @entity.save
      @entity.tags_string = params[:tags_string].to_s
      add_illustrations if params[:illustrations].any?
      redirect_to @entity
    else
      render :new
    end
  end

  # get /posts/:id
  def show
  end

  # patch /posts/:id
  def update
    if @entity.update(entity_parameters)
      @entity.tags_string = params[:tags_string].to_s
      add_illustrations if params[:illustrations].any?
      redirect_to @entity
    else
      render :edit
    end
  end

  # delete /posts/:id
  def destroy
    @entity.destroy
    redirect_to posts_path
  end

  # get /posts/tagged/:tag_name
  def tagged
    @tag        = Tag.find_by! body: params[:tag_name]
    @collection = Post.tagged_page @tag, current_page
  end

  protected

  def set_entity
    @entity = Post.find params[:id]
  end

  def entity_parameters
    params.require(:post).permit(Post.entity_parameters)
  end

  def add_illustrations
    params[:illustrations].values.each do |illustration_data|
      unless illustration_data[:title].blank? || illustration_data[:image].blank?
        @entity.illustrations.create(illustration_data)
      end
    end
  end
end
