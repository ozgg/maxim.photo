class IndexController < ApplicationController
  def index
    collect_photos
  end

  def about
  end

  protected

  def collect_photos
    ids = []
    Category.recent_photos.each { |photo| ids << photo.id }
    Album.recent_photos.each { |photo| ids << photo.id }
    @photos = Photo.where(id: ids).all
  end
end
