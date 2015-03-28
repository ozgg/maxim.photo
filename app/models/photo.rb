class Photo < ActiveRecord::Base
  belongs_to :album, counter_cache: true

  validates_presence_of :image

  def name(locale)
    method_name, result = "name_#{locale}", ''
    if respond_to? method_name
      result = send(method_name)
    end

    result.blank? ? I18n.t(:untitled) : result
  end
end
