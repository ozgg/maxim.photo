class Category < ActiveRecord::Base
  include TranslatableNames

  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  mount_uploader :image, HeadingUploader

  enum visibility: [:hidden, :visible, :main]

  def self.for_anonymous
    where(visibility: [visibilities[:visible], visibilities[:main]])
  end
end
