module CategoriesHelper

  # Link to category with slug as id
  #
  # @param [Category] category
  # @return [String]
  def category_by_slug(category, options = {})
    link_to category.name(I18n.locale), category_path(id: category.slug), options
  end
end
