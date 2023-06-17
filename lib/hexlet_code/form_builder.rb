# frozen_string_literal: true

require_relative 'form_tags/input_string'
require_relative 'form_tags/input_submit'
require_relative 'form_tags/label'
require_relative 'form_tags/input_text'

module HexletCode
  class FormBuilder
    attr_accessor :data, :attributes, :fields, :nodes

    EXCLUDE_ATTRIBUTES = %i[as].freeze

    def initialize(data, url: '#', method: 'post', **attr)
      @attributes = attr.merge(action: url, method:)
      @data = data
      @fields = {}
      @nodes = []

      @data.each_pair { |name, value| @fields[name.to_sym] = value }

      yield self if block_given?
    end

    def label(name, attributes = {})
      attributes[:for] ||= name
      attributes[:value] ||= name.capitalize

      FormTags::Label.new(attributes)
    end

    def input(name, attributes = {})
      only_attributes = input_attributes(name, attributes)

      input_type = attributes[:as] || :string
      class_name = "HexletCode::FormTags::Input#{input_type.capitalize}"
      tag = Object.const_get(class_name).new(only_attributes)
      @nodes.push(label(name), tag)

      tag
    end

    def submit(value = nil, attributes = {})
      attributes[:value] = value
      tag = FormTags::InputSubmit.new(attributes)
      @nodes << tag

      tag
    end

    class << self
      def build(data, attributes = {})
        new(data, **attributes)
      end
    end

    def input_attributes(name, attributes = {})
      only_attributes = attributes.reject { |key| EXCLUDE_ATTRIBUTES.include?(key) }
      only_attributes[:name] = name
      only_attributes[:value] = @data.public_send(name)
      only_attributes
    end
  end
end
