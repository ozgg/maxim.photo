# Biovision CMS component and settings
#
# Attributes:
#   created_at [DateTime]
#   priority [Integer]
#   settings [JSON]
#   slug [String]
#   updated_at [DateTime]
class Component < ApplicationRecord
  include Biovision::FlatPriority
  include Biovision::RequiredUniqueSlug

  # Find component by slug
  #
  # @param [String|Class] slug
  def self.[](slug)
    find_by(slug: slug.respond_to?(:slug) ? slug.slug : slug)
  end
end
