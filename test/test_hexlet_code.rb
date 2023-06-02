# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    @form_for_html = YAML.safe_load(fixture_load('form_for_html.yml'))
  end

  def test_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_empty
    html_assert_equal '<form action="#" method="post"></form>', HexletCode.form_for(@user)
    html_assert_equal '<form action="/users" method="post"></form>', HexletCode.form_for(@user, url: '/users')
  end

  def test_form_for_input
    html_assert_equal(@form_for_html['input']) { HexletCode.form_for(@user) { |f| f.input :name } }

    html_assert_equal(@form_for_html['input_add_class']) do
      HexletCode.form_for(@user, url: '#') { |f| f.input :name, class: 'user-input' }
    end
  end

  def test_form_for_textarea
    html_assert_equal(@form_for_html['textarea']) do
      HexletCode.form_for @user, url: '#' do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
    end

    html_assert_equal(@form_for_html['textarea_defaults']) do
      HexletCode.form_for(@user) { |f| f.input :job, as: :text }
    end
  end

  def test_form_for_submit
    [['submit', nil], %w[submit_defaults Wow]].each do |(key, value)|
      html_assert_equal(@form_for_html[key]) do
        HexletCode.form_for(@user) { |f| f.submit value }
      end
    end
  end

  def test_form_for_raise
    assert_raises(NoMethodError) do
      HexletCode.form_for(@user, url: '/users') do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
      end
    end
  end

  def test_form_for_group
    user = User.new job: 'hexlet'
    html_assert_equal(@form_for_html['group_input_textarea_submit']) do
      HexletCode.form_for(user, url: '/users') do |f|
        f.input :name
        f.input :job, as: :text
        f.submit 'Wow'
      end
    end
  end
end
