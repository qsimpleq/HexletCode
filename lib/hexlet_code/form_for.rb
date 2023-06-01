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

      label = format '<label for="%<name>s">%<Name>s</label>', name:, Name: name.capitalize

      reject_keys = ->(key) { key == :as || options[:as] == :text && key == :value }
      input = HexletCode::Tag.build(tag, options.reject { |key| reject_keys.call key }) do
        options[:value] if options[:as] == :text
      end

      @nodes.push label, input
    end

    def submit(value = nil)
      value ||= 'Save'
      @nodes << HexletCode::Tag.build(:input, { type: :submit, value: })
      nodes[-1]
    end

    private

    def input_options(name, options = {})
      (tag, options) = options[:as] == :text ? input_textarea_option_defaults(options) : input_option_defaults(options)

      value = @data.public_send name
      value.nil? ? options.delete(:value) : options[:value] = value
      options[:name] = name
      [tag, options]
    end

    def input_option_defaults(options = {})
      options[:type] ||= 'text'
      ['input', options]
    end

    def input_textarea_option_defaults(options = {})
      options[:cols] ||= 20
      options[:rows] ||= 40
      ['textarea', options]
    end
  end
end
