class IndexController < ApplicationController
  def index
    @photos = Photo.visible.order('id desc').first(6)
  end

  def about
  end
end
