# frozen_string_literal: true

require_relative 'form_tags/form'
require_relative 'form_tags/input'
require_relative 'form_tags/input_submit'
require_relative 'form_tags/label'
require_relative 'form_tags/textarea'

module HexletCode
  class FormBuilder
    attr_accessor :data, :attributes, :fields, :nodes

    DEFAULT_ATTRIBUTES = {
      action: '#',
      method: 'post'
    }.freeze

    def initialize(data = Struct.new, attributes = {})
      (attributes[:action] = attributes.delete(:url)) if attributes.key?(:url)
      @attributes = {}.merge(DEFAULT_ATTRIBUTES, attributes)
      @data = data
      @fields = {}
      @nodes = []

      @data.each_pair { |name, value| @fields[name.to_sym] = value }

      yield self if block_given?
    end

    def label(name, attributes = {})
      attributes[:for] ||= name
      attributes[:value] ||= name.capitalize
      tag = HexletCode::FormTags::Label.new(attributes)
      @nodes << tag

      tag
    end

    def input(name, attributes = {})
      only_attributes = input_attributes(name, attributes)

      label(name)

      tag = if attributes[:as] == :text || (attributes[:as] == :value && attributes[:as] == :text)
              HexletCode::FormTags::Textarea.new(only_attributes)
            else
              HexletCode::FormTags::Input.new(only_attributes)
            end
      @nodes << tag

      tag
    end

    def submit(value, attributes = {})
      attributes[:value] = value
      tag = HexletCode::FormTags::InputSubmit.new(attributes)
      @nodes << tag

      tag
    end

    class << self
      def build(data, attributes = {})
        new(data, attributes)
      end
    end

    def input_attributes(name, attributes = {})
      reject_keys = ->(key) { key == :as || (key == :value && attributes[:as] == :text) }
      only_attributes = attributes.reject { |key| reject_keys.call key }
      only_attributes[:name] = name
      only_attributes[:value] = @data.public_send(name)
      only_attributes
    end
  end
end
