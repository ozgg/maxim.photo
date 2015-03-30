class Photo < ActiveRecord::Base
  belongs_to :album, counter_cache: true
  has_many :photo_categories, dependent: :destroy
  has_many :categories, through: :photo_categories

  validates_presence_of :image

  mount_uploader :image, PhotoUploader

  def name(locale)
    method_name, result = "name_#{locale}", ''
    if respond_to? method_name
      result = send(method_name)
    end

    result.blank? ? I18n.t(:untitled) : result
  end

  def category_ids=(ids)

  end

  def has_category?(category)
    !PhotoCategory.by_pair(self, category).nil?
  end
end
