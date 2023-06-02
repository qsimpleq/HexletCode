# frozen_string_literal: true

require 'test_helper'

class TagTest < Minitest::Test
  def test_build_br
    assert_equal HexletCode::Tag.build('br'), '<br>'
  end

  def test_build_img
    assert_equal HexletCode::Tag.build('img', src: 'path/to/image'), '<img src="path/to/image">'
  end

  def test_build_input
    assert_equal HexletCode::Tag.build('input', type: 'submit', value: 'Save'), '<input type="submit" value="Save">'
  end

  def test_build_label
    assert_equal HexletCode::Tag.build('label') { 'Email' }, '<label>Email</label>'
  end

  def test_build_label_block
    assert_equal HexletCode::Tag.build('label', for: 'email') { 'Email' }, '<label for="email">Email</label>'
  end

  def test_build_div
    assert_equal HexletCode::Tag.build('div'), '<div></div>'
  end
end
