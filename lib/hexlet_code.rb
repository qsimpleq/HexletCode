# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form builder loader
module HexletCode
  INDENT = ' ' * 2

  autoload :Tag, 'hexlet_code/tag'
  autoload :FormFor, 'hexlet_code/form_for'

  def self.form_for(data, options = {})
    form = HexletCode::FormFor.new(data, options)
    form.render { yield form if block_given? }
  end
end
