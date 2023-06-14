# frozen_string_literal: true

require_relative 'form_tags/form'
require_relative 'form_tags/input_string'
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

    def initialize(data, attributes = {})
      attr = if attributes.key?(:url)
               attributes[:action] = attributes[:url]
               attributes.except(:url)
             else
               attributes
             end
      @attributes = {}.merge(DEFAULT_ATTRIBUTES, attr)
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

      input_type = attributes[:as] || :string
      class_name = "HexletCode::FormTags::Input#{input_type.capitalize}"
      tag = Object.const_get(class_name).new(only_attributes)
      @nodes << tag

      tag
    end

    def submit(value = nil, attributes = {})
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
