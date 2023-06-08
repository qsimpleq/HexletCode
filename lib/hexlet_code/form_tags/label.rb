# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class Label < HexletCode::FormTags::BaseTag
      NAME = :label

      def initialize(attributes = {})
        super
        @name = NAME
        @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
        @block = -> { @value }
        @attributes.delete(:value)
      end
    end
  end
end
