# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class Textarea < HexletCode::FormTags::BaseTag
      NAME = :textarea
      DEFAULT_ATTRIBUTES = {
        cols: 20,
        rows: 40
      }.freeze

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
