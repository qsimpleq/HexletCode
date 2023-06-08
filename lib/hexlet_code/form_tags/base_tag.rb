# frozen_string_literal: true

module HexletCode
  module FormTags
    class BaseTag
      attr_reader :name, :block
      attr_accessor :value, :attributes

      DEFAULT_ATTRIBUTES = {}.freeze

      def initialize(attributes = {})
        attributes.delete(:value) if attributes.key?(:value) && attributes[:value].nil?
        @value = attributes[:value]
        @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
      end
    end
  end
end
