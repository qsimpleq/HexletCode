# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class Label < BaseTag
      NAME = :label

      def initialize(attributes = {})
        super
        @block = -> { @value }
        @attributes = @attributes.except(:value)
      end
    end
  end
end
