# frozen_string_literal: true

module Biovision
  # Adds list of toggleable attributes to model
  #
  # @author Maxim Khan-Magomedov <maxim.km@gmail.com>
  module Toggleable
    extend ActiveSupport::Concern

    included do
      class_attribute :toggleable_attributes, instance_predicate: false, instance_accessor: false

      # @param [String, Symbol] attribute
      # @return [Hash]
      def toggle_attribute(attribute)
        return unless toggleable_attributes.include? attribute.to_sym

        assign_attributes(attribute => !attributes[attribute.to_s])
        save!
        { attribute => self[attribute] }
      end
    end

    # Additional class methods
    module ClassMethods

      private

      # @param [Array<Symbol>] attributes
      def toggleable(*attributes)
        cattr_accessor :toggleable_attributes
        self.toggleable_attributes = attributes.flatten
      end
    end
  end
end
