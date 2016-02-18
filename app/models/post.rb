class Post < ActiveRecord::Base
  include TimeHelpers

  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags

  validates_presence_of :title, :body

  mount_uploader :image, ImageUploader

  PER_PAGE = 5

  scope :recent, -> { order 'id desc' }

  def self.page_for_user(page)
    recent.page(page).per(PER_PAGE)
  end

  def self.tagged_page(tag, page)
    recent.joins(:post_tags).where(post_tags: { tag: tag }).page(page).per(PER_PAGE)
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
    (lead.blank? ? title : lead)[0..110]
  end

  def tags_string
    tags.ordered_by_body.map { |tag| tag.body }.join(', ')
  end

  def tags_string=(tags_string)
    list_of_tags = []
    tags_string.split(',').each do |body|
      list_of_tags << Tag.find_or_create_by(body: body.squish) unless body.blank?
    end
    self.tags = list_of_tags.uniq
  end
end
