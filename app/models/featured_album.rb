# frozen_string_literal: true

# Featured album for frontpage
#
# Attributes:
#   album_id [Album]
#   priority [Integer]
class FeaturedAlbum < ApplicationRecord
  include FlatPriority

  belongs_to :album

  validates_uniqueness_of :album_id

  scope :list_for_administration, -> { includes(:album).ordered_by_priority }
  scope :list_for_visitors, -> { includes(:album).ordered_by_priority }

  def self.frontpage
    list_for_visitors.map(&:album)
  end

  def image
    album.image
  end

  def image_alt_text
    album.image_alt_text
  end
end
