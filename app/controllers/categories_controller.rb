class CategoriesController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # get /categories
  def index

  end

  # get /categories/new
  def new
    @category = Category.new
  end

  # post /categories
  def create
    render :new
  end

  # get /categories/:id
  def show

  end

  # get /categories/:id/edit
  def edit

  end

  # patch /categories/:id
  def update
    render :edit
  end

  # delete /categories/:id
  def destroy
    redirect_to categories_path
  end

  protected

  def set_category
    id = params[:id]
    if id.to_i.to_s == id
      @category = Category.find id.to_i
    else
      @category = Category.find_by slug: id
      redirect_to categories_path unless @category.is_a? Category
    end
  end
end
