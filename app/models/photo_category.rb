class PhotoCategory < ActiveRecord::Base
  belongs_to :photo
  belongs_to :category

  validates_presence_of :photo, :category
  validates_uniqueness_of :photo_id, scope: :category_id
  after_create :increment_photo_count
  before_destroy :decrement_photo_count

  def self.by_pair(photo, category)
    find_by photo: photo, category: category
  end

  def self.set_link(photo_id, category_id, linked)
    link = find_by photo_id: photo_id, category_id: category_id
    if linked
      create!(photo_id: photo_id, category_id: category_id) if link.nil?
    else
      link.destroy unless link.nil?
    end
  end

  private

  def increment_photo_count
    category.increment! :photo_count
  end

  def decrement_photo_count
    category.decrement! :photo_count
  end
end
