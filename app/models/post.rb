class Post < ActiveRecord::Base
  include TimeHelpers

  validates_presence_of :title, :body

  mount_uploader :image, ImageUploader

  PER_PAGE = 5

  scope :recent, -> { order 'id desc' }

  def self.page_for_user(page)
    recent.page(page).per(PER_PAGE)
  end

  def self.entity_parameters
    %i(title image lead body)
  end

  def adjacent
    {
        prev: Post.where('id < ?', self.id).recent.first,
        next: Post.where('id > ?', self.id).recent.last,
    }
  end

  def headline
    lead.blank? ? title : lead
  end
end
