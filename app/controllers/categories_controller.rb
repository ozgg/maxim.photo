class CategoriesController < ApplicationController
  before_action :allow_authorized_only, except: [:index, :show]
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # get /categories
  def index
    selection   = current_user ? Category : Category.for_anonymous
    @categories = selection.order('priority desc').all
  end

  # get /categories/new
  def new
    @category = Category.new
  end

  # post /categories
  def create
    @category = Category.new category_parameters
    if @category.save
      flash[:notice] = t('category.created')
      redirect_to @category
    else
      render :new
    end
  end

  # get /categories/:id
  def show

  end

  # get /categories/:id/edit
  def edit

  end

  # patch /categories/:id
  def update
    if @category.update(category_parameters)
      flash[:notice] = t('category.updated')
      redirect_to @category
    else
      render :edit
    end
  end

  # delete /categories/:id
  def destroy
    if @category.destroy
      flash[:notice] = t('category.deleted')
    end
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

  def category_parameters
    allowed = [
        :image, :priority, :visibility, :slug,
        :name_ru, :name_en, :name_es, :description_ru, :description_en, :description_es
    ]
    params.require(:category).permit(allowed)
  end
end
