# frozen_string_literal: true

# Featured photo for homepage
#
# Attributes:
#   photo_id [Photo]
#   priority [Integer]
class FeaturedPhoto < ApplicationRecord
  include FlatPriority

  belongs_to :photo

  validates_uniqueness_of :photo_id

  scope :visible, -> { joins(:photos).where(photos: { visible: true }) }
  scope :list_for_visitors, -> { visible.ordered_by_priority }
  scope :list_for_administration, -> { ordered_by_priority }
end
