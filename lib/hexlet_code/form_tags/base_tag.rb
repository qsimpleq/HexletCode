# frozen_string_literal: true

module HexletCode
  module FormTags
    class BaseTag
      attr_reader :name, :block
      attr_accessor :value, :attributes

      NAME = :base_tag
      DEFAULT_ATTRIBUTES = {}.freeze

      def initialize(attributes = {})
        @name = self.class::NAME
        attributes.delete(:value) if attributes[:value].nil?
        @value = attributes[:value]
        @attributes = {}.merge(self.class::DEFAULT_ATTRIBUTES, attributes)
      end
    end
  end
end
