class Illustration < ActiveRecord::Base
  PER_PAGE = 9

  belongs_to :post
  validates_presence_of :post_id, :title

  mount_uploader :image, ImageUploader

  after_initialize :set_next_priority

  scope :ordered_by_priority, -> { order 'priority asc' }

  def self.page_for_administration(page)
    order('post_id desc, priority asc').page(page).per(PER_PAGE)
  end

  private

  def set_next_priority
    if id.nil?
      self.priority = Illustration.where(post: post).maximum(:priority).to_i + 1
    end
  end
end
