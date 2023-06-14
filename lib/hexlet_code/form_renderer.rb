# frozen_string_literal: true

require_relative 'form_builder'
require_relative 'tag'
require_relative 'form_tags/form'

module HexletCode
  class FormRenderer
    HTML_INDENT = ' ' * 2

    def initialize(form)
      @form = form
    end

    def to_html
      form_node = HexletCode::FormTags::Form.new(@form.attributes)
      html = ''
      HexletCode::Tag.build(form_node.name, form_node.attributes) do
        html += generate_html_from_nodes(html)
      end
    end

    private

    def generate_html_from_nodes(string = '')
      return '' unless @form.nodes.any?

      string += "\n"
      string += @form.nodes.map do |node|
        tag_params = [node.name, node.attributes]
        tag_params << node.block unless node.block.nil?

        "#{HTML_INDENT}#{HexletCode::Tag.build(*tag_params)}"
      end.join("\n")

      "#{string}\n"
    end
  end
end
