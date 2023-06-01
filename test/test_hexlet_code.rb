# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
    @html = YAML.safe_load fixture_load('form_for_html.yml')
  end

  def test_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_empty
    html_assert_equal '<form action="#" method="post"></form>', HexletCode.form_for(@user)
    html_assert_equal '<form action="/users" method="post"></form>', HexletCode.form_for(@user, url: '/users')
  end

  def test_form_for_input_basic
    html_assert_equal(@html[1], HexletCode.form_for(@user) do |f|
      f.input :name
      f.input :job, as: :text
    end)

    html_assert_equal(@html[2]) do
      HexletCode.form_for @user, url: '#' do |f|
        f.input :name, class: 'user-input'
        f.input :job
      end
    end
  end

  def test_form_for_input_extra
    html_assert_equal(@html[3]) do
      HexletCode.form_for @user do |f|
        f.input :job, as: :text
      end
    end

    html_assert_equal(@html[4]) do
      HexletCode.form_for @user, url: '#' do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
    end
  end

  def test_form_for_input_raise
    assert_raises(NoMethodError) do
      HexletCode.form_for(@user, url: '/users') do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
      end
    end
  end
end
