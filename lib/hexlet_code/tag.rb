# frozen_string_literal: true

module HexletCode
  # Generate HTML tag string
  module Tag
    SINGLE_TAGS = %w[br hr img input wbr].freeze

    def self.build(tag, options = {})
      tag = tag.to_s.downcase

      if options.any?
        attributes = options.keys.sort.each_with_object([]) do |key, acc|
          acc << " #{key}=\"#{options[key]}\""
        end.join
      end

      result = "<#{tag}#{attributes}>"
      result += "#{yield if block_given?}</#{tag}>" unless SINGLE_TAGS.include?(tag)

      result
    end
  end
end
