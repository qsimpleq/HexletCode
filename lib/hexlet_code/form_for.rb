# frozen_string_literal: true

module HexletCode
  # Build a form instance
  class FormFor
    attr_accessor :data, :options, :nodes

    def initialize(data, options = {})
      options[:action] = options[:url] || '#'
      options[:method] ||= 'post'
      @data = data
      @options = options
      @nodes = []
    end

    def render
      HexletCode::Tag.build(:form, @options.reject { |key| key == :url }) do
        if block_given?
          yield self
          "\n#{nodes.map { |node| "#{INDENT}#{node}\n" }.join}" if nodes.any?
        end
      end
    end

    def input(name, options = {})
      (tag, options) = input_options(name, options)

      reject_keys = ->(key) { key == :as || options[:as] == :text && key == :value }
      node = HexletCode::Tag.build(tag, options.reject { |key| reject_keys.call key }) do
        options[:value] if options[:as] == :text
      end

      @nodes << node
      node
    end

    private

    def input_options(name, options = {})
      options[:value] = @data.public_send name
      options[:name] = name
      tag = 'input'

      if options[:as] == :text
        tag = 'textarea'
        options[:cols] ||= 20
        options[:rows] ||= 40
      end

      options[:type] ||= 'text' if tag == 'input'
      [tag, options]
    end
  end
end
