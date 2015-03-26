class Category < ActiveRecord::Base
  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  enum visibility: [:hidden, :visible, :main]

  def name(locale)
    case locale.to_sym
      when :ru
        name_ru
      when :en
        name_en
      when :es
        name_es
      else
        slug
    end
  end
end
