module ApplicationHelper
  def selected_page
    @page ||= (params[:page] || 1)
  end

  def page_number
    I18n.t(:page_number, page: selected_page)
  end
end
