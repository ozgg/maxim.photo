class Album < ActiveRecord::Base
  include TranslatableNames

  has_many :photos, dependent: :nullify

  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  mount_uploader :image, HeadingUploader

  def self.list_for_user(user)
    if user.nil?
      where(hidden: false).order('priority desc').all
    else
      order('priority desc').all
    end
  end

  def self.list_for_photo_form
    albums = [[I18n.t(:not_set), '']]
    self.order('slug asc').each { |album| albums << [album.slug, album.id] }
    albums
  end

  def self.recent_photos
    photos = []
    where(hidden: false).each do |album|
      photo = album.photos.last
      photos << photo unless photo.nil?
    end
    photos
  end
end
