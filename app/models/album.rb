class Album < ActiveRecord::Base
  include TranslatableNames

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
end
