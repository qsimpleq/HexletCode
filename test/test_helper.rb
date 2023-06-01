# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'hexlet_code'

require 'minitest/autorun'
require 'yaml'

HTML_ERROR = "Wrong value:\n%s\nExpected:\n%s"
def fixture_load(name)
  File.read "#{File.dirname(__FILE__)}/fixtures/#{name}"
end

def html_assert_equal(expected, result = nil)
  expected = expected.strip
  result = yield if block_given? && result.nil?
  assert_equal expected, result, format(HTML_ERROR, result, expected)
end
