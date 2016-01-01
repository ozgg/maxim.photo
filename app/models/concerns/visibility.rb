module Visibility
  extend ActiveSupport::Concern

  included do
    scope :visibility, ->(visible = nil) { where visible: visible unless visible.nil? }
  end
end
