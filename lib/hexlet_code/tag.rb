# frozen_string_literal: true

module HexletCode
  module Tag
    def self.build(tag, options = {}, &block)
      tag = tag.to_s.downcase
      if options.any?
        attributes = options.each_with_object([]) do |(key, value), acc|
          acc << " #{key}=\"#{value}\""
        end.join
      end

      if %w[br hr img input wbr].include? tag.to_s.downcase
        "<#{tag}#{attributes}>"
      else
        "<#{tag}#{attributes}>#{block.call if block_given?}</#{tag}>"
      end
    end
  end
end
