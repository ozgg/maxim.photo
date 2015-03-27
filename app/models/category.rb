class Category < ActiveRecord::Base
  validates_presence_of :slug, :name_ru, :name_en, :name_es
  validates_uniqueness_of :slug, :name_ru, :name_en, :name_es

  enum visibility: [:hidden, :visible, :main]

  def self.for_anonymous
    where(visibility: [Category.visibilities[:visible], Category.visibilities[:main]])
  end

  # Get localized name of category
  #
  # @param [Symbol] locale
  # @return [String]
  def name(locale)
    method_name = "name_#{locale}"
    respond_to?(method_name) ? send(method_name) : slug
  end
end
