module ApplicationHelper
  def create_icon(path, title = t(:create), options = {})
    link_to image_tag('icons/create.png', alt: title), path, options
  end

  def back_icon(path, title = t(:back), options = {})
    link_to image_tag('icons/previous.png', alt: title), path, options
  end

  def edit_icon(path, title = t(:edit), options = {})
    link_to image_tag('icons/edit.png', alt: title), path, options
  end

  def destroy_icon(entity, title = t(:delete), options = {})
    default = { method: :delete, data: { confirm: t(:are_you_sure) } }
    link_to image_tag('icons/delete.png', alt: title), entity, default.merge(options)
  end
end
