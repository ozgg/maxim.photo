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
end
