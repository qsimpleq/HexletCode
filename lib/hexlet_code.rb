# frozen_string_literal: true

require_relative 'hexlet_code/version'
require_relative 'hexlet_code/form_builder'
require_relative 'hexlet_code/form_renderer'
require_relative 'hexlet_code/form_tags/form'

# Form builder loader
module HexletCode
  INDENT = ' ' * 2

  def self.form_for(data, options = {}, &)
    form = HexletCode::FormBuilder.new(data, options, &)
    renderer = HexletCode::FormRenderer.new(form)

    renderer.to_html
  end
end
