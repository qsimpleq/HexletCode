# frozen_string_literal: true

require_relative 'base_tag'
require_relative 'input_string'

module HexletCode
  module FormTags
    class InputSubmit < InputString
      DEFAULT_ATTRIBUTES = {
        type: 'submit',
        value: 'Save'
      }.freeze
    end
  end
end
