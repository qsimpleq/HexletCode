# frozen_string_literal: true

require_relative 'hexlet_code/version'

# Form builder loader
module HexletCode
  autoload :Tag, 'hexlet_code/tag'

  def self.form_for(_id, options = {}, &block)
    options[:action] = options[:url] || '#'
    options[:method] ||= 'post'

    HexletCode::Tag.build(:form, options.filter { |key| key != :url }, &block)
  end
end
