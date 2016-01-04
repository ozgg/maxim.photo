class PortfolioController < ApplicationController
  def index
    @themes = Theme.list_for_visitor
  end

  def theme
    @theme = Theme.find_by! slug: params[:theme]
  end

  def album
    set_album
  end

  def photo
    set_album
    @photo = Photo.find_by! album: @album, id: params[:id]
  end

  private

  def set_album
    theme  = Theme.find_by! slug: params[:theme]
    @album = Album.find_by! theme: theme, slug: params[:album]
  end
end
