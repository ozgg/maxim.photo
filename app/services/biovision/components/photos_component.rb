# frozen_string_literal: true

module Biovision
  module Components
    # Handler for photos component
    class PhotosComponent < BaseComponent
      SLUG = 'photos'

      def use_parameters?
        false
      end
    end
  end
end
