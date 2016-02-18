class Tag < ActiveRecord::Base
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  validates_presence_of :body, :post_count

  scope :ordered_by_body, -> { order 'body asc' }

  def self.list_for_administration
    ordered_by_body.all
  end

  def self.entity_parameters
    %i(body)
  end
end
