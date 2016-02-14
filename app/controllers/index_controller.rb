class IndexController < ApplicationController
  def index
    @photos = Photo.recent_photos
  end

  def about
  end
end
