class IndexController < ApplicationController
  def index
    @themes = Theme.list_for_visitor
  end

  def about
  end
end
