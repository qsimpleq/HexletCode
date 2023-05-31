# frozen_string_literal: true

module HexletCode
  # Generate HTML tag string
  module Tag
    def self.build(tag, options = {}, &block)
      tag = tag.to_s.downcase
      if options.any?
        attributes = options.each_with_object([]) do |(key, value), acc|
          acc << " #{key}=\"#{value}\""
        end.join
      end

      single_tags = %w[br hr img input wbr]
      "<#{tag}#{attributes}>" + "#{block.call if block_given?}</#{tag}>" unless single_tags.include? tag.to_s.downcase
    end
  end
end
