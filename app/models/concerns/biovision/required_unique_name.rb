# frozen_string_literal: true

module Biovision
  # Mixin for adding required unique name constrain
  module RequiredUniqueName
    extend ActiveSupport::Concern

    included do
      before_validation { self.name = name.strip unless name.nil? }
      validates_presence_of :name
      validates_uniqueness_of :name

      scope :ordered_by_name, -> { order(:name) }
      scope :with_name_like, ->(v) { where('name ilike ?', "%#{v}%") unless v.blank? }
      scope :with_name, ->(v) { where('lower(name) = lower(?)', v) unless v.blank? }
    end
  end
end
