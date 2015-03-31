class IndexController < ApplicationController
  def index
    @photos = Category.recent_photos
  end

  def about
  end
end
