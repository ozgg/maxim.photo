class Post < ActiveRecord::Base
  validates_presence_of :title, :body

  mount_uploader :image, ImageUploader

  PER_PAGE = 5

  def self.page_for_user(page)
    order('id desc').page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    %i(title image lead body)
  end
end
