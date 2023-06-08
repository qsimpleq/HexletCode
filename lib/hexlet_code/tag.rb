# frozen_string_literal: true

module HexletCode
  # Generate HTML form_tags string
  module Tag
    SINGLE_TAGS = %w[br hr img input wbr].freeze

    def self.build(tag, attributes = {}, block = nil)
      tag = tag.to_s.downcase
      attributes_string = build_attributes(attributes)
      result = "<#{tag}#{attributes_string}>"

      unless SINGLE_TAGS.include?(tag)
        content = if block_given?
                    yield
                  elsif !block.nil? && block.instance_of?(Proc)
                    block.call
                  end
        result += "#{content}</#{tag}>"
      end

      result
    end

    def self.build_attributes(attributes = {})
      attributes
        .keys
        .sort
        .each_with_object([]) do |key, acc|
        acc << " #{key}=\"#{attributes[key]}\""
      end.join
    end
  end
end
