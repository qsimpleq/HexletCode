# frozen_string_literal: true

require_relative 'hexlet_code/version'

require_relative 'hexlet_code/form_builder'
require_relative 'hexlet_code/form_renderer'
require_relative 'hexlet_code/form_tags/form'

# Form builder loader
module HexletCode
  INDENT = ' ' * 2

  autoload :Tag, 'hexlet_code/tag'

  def self.form_for(data, options = {})
    form = Form.new(data, options) { yield _1 if block_given? }

    form.render_by(:html)
  end

  class Form
    attr_reader :form

    def initialize(data = Struct.new, attributes = {}, &)
      @form = HexletCode::FormBuilder.new(data, attributes, &)
    end

    def render_by(type)
      renderer = HexletCode::FormRenderer.new(@form)

      renderer.public_send("to_#{type}")
    end
  end
end
