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
    end
  end
end
