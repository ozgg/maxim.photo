class Category < ActiveRecord::Base
  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  enum visibility: [:hidden, :visible, :main]

end
