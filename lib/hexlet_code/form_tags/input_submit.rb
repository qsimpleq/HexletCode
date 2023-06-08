# frozen_string_literal: true

require_relative 'base_tag'
require_relative 'input'

module HexletCode
  module FormTags
    class InputSubmit < HexletCode::FormTags::Input
      DEFAULT_ATTRIBUTES = {
        type: 'submit',
        value: 'Save'
      }.freeze

      def initialize(attributes = {})
        super
        @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
      end
    end
  end
end
