# frozen_string_literal: true

AboutController.class_eval do
  # get /about
  def index
    @editable_page = EditablePage.localized_page('about', locale)
  end
end
