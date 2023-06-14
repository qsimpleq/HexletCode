# frozen_string_literal: true

require_relative 'base_tag'

module HexletCode
  module FormTags
    class InputString < BaseTag
      NAME = :input
      DEFAULT_ATTRIBUTES = { type: 'text' }.freeze
    end
  end
end
