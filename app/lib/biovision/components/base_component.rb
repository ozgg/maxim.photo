module Biovision
  module Components
    # Base Biovision CMS component
    class BaseComponent
      extend Base::ComponentSettings

      attr_reader :component, :slug, :name

      # @param [Component] component
      def initialize(component)
        @component = component
        @slug = component&.slug || 'base'
        @name = I18n.t("biovision.components.#{slug}.name", default: slug)
      end

      # @param [String] slug
      def self.handler_class(slug)
        handler_name = "biovision/components/#{slug}_component".classify
        handler_name.safe_constantize || BaseComponent
      end

      # Receive component-specific handler by component slug
      #
      # @param [String|Component] input
      # @return [BaseComponent]
      def self.handler(input)
        type = input.respond_to?(:slug) ? input.slug : input.to_s
        handler_class(type)[user]
      end

      def self.slug
        to_s.demodulize.to_s.underscore.gsub('_component', '')
      end

      # Receive component-specific handler by class name for component.
      #
      # e.g.: Biovision::Components::UsersComponent[]
      def self.[]
        new(Component[slug])
      end

      # Model list for automatic component creation
      def self.dependent_models
        []
      end

      def self.create
        Component.create(slug: slug, settings: default_settings)
      end
    end
  end
end
