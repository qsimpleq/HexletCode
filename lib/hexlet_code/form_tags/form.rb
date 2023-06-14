# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class Form < BaseTag
      NAME = :form
      DEFAULT_ATTRIBUTES = {
        action: '#',
        method: 'post'
      }.freeze

      def initialize(attributes = {})
        super
        @name = NAME
        @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
      end
    end
  end
end
