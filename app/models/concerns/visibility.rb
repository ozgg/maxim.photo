module Visibility
  extend ActiveSupport::Concern

  included do
    scope :visibility, ->(visible = nil) { where visible: visible unless visible.nil? }
    scope :only_visible, ->(flag = true) { where visible: true if flag }
  end
end
