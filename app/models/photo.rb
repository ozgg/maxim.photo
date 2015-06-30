class Photo < ActiveRecord::Base
  scope :visible, -> { where(visible: true) }
end
