# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, keyword_init: true)
  ERROR = "Wrong value: %s.\nExpected: %s"

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  # noinspection RubyDynamicConstAssignment
  def test_form_for
    user = User.new name: 'Rob', job: 'Driver'

    expected = '<form action="#" method="post"></form>'
    result = HexletCode.form_for(user) { |f| }
    assert expected == result, format(ERROR, result, expected)

    expected = '<form action="/users" method="post"></form>'
    result = HexletCode.form_for(user, url: '/users') { |f| }
    assert expected == result, format(ERROR, result, expected)
  end
end
