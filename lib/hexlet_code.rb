# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form builder loader
module HexletCode
  INDENT = ' ' * 2

  autoload :Tag, 'hexlet_code/tag'
  autoload :Form, 'hexlet_code/form'

  def self.form_for(data, options = {})
    form = HexletCode::Form.new(data, options) { yield _1 if block_given? }
    form.render
  end
end
