# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class InputText < BaseTag
      NAME = :textarea
      DEFAULT_ATTRIBUTES = {
        cols: 20,
        rows: 40
      }.freeze

      def initialize(attributes = {})
        super
        @attributes = @attributes.except(:value)
        @block = -> { @value }
      end
    end
  end
end
