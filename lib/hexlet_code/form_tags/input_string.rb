# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class InputString < BaseTag
      NAME = :input
      DEFAULT_ATTRIBUTES = { type: 'text' }.freeze

      def initialize(attributes = {})
        super
        @name = NAME
        @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
      end
    end
  end
end
