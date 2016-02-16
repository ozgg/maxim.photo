class IndexController < ApplicationController
  def index
    @photos = Photo.recent_photos
    @posts  = Post.recent.first(3)
  end

  def about
  end
end
