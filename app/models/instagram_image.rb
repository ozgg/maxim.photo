# frozen_string_literal: true

# Instagram image
#
# Attributes:
#   code [String]
#   created_at [DateTime]
#   slug [String]
#   thumbnail_url [String]
#   updated_at [DateTime]
class InstagramImage < ApplicationRecord
  validates_presence_of :code, :slug, :thumbnail_url
  validates_uniqueness_of :slug

  scope :list_for_visitors, -> { order('id desc') }

  def url
    "https://instagram.com/p/#{code}/"
  end
end
