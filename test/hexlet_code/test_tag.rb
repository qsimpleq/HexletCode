# frozen_string_literal: true

require 'test_helper'

class TagTest < Minitest::Test
  def test_build
    assert HexletCode::Tag.build('br') == '<br>'
    assert HexletCode::Tag.build('img', src: 'path/to/image') == '<img src="path/to/image">'
    assert HexletCode::Tag.build('input', type: 'submit', value: 'Save') == '<input type="submit" value="Save">'
    assert HexletCode::Tag.build('label') { 'Email' } == '<label>Email</label>'
    assert HexletCode::Tag.build('label', for: 'email') { 'Email' } == '<label for="email">Email</label>'
    assert HexletCode::Tag.build('div') == '<div></div>'
  end
end
