class Category < ActiveRecord::Base
  include TranslatableNames

  has_many :photo_categories, dependent: :destroy
  has_many :photos, through: :photo_categories

  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  mount_uploader :image, HeadingUploader

  enum visibility: [:hidden, :visible, :main]

  def self.for_anonymous
    where(visibility: [visibilities[:visible], visibilities[:main]])
  end
end
