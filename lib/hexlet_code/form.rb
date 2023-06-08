# frozen_string_literal: true

require_relative 'form_builder'
require_relative 'form_renderer'
require_relative 'form_tags/form'

module HexletCode
  # Build a form instance
  class Form
    attr_reader :form

    def initialize(data = Struct.new, attributes = {}, &block)
      @form = HexletCode::FormBuilder.new(data, attributes, &block)
    end

    def render(type = :html)
      renderer = HexletCode::FormRenderer.new(@form)
      type_method = "to_#{type}"

      unless renderer.respond_to?(type_method)
        raise NoMethodError, \
              "This render type is not supported: #{type}. No such method: HexletCode::FormRenderer#{type_method}"
      end

      renderer.send(type_method)
    end
  end
end
