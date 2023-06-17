# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new(name: 'rob', job: 'hexlet', gender: 'm')
    @form_for_html = {}
    @fixture_files = %w[
      form_for-post-empty.html
      form_for-post-users-empty.html
      form_for-post-empty-input.html
      form_for-post-empty-input_add_class.html
      form_for-post-empty-textarea.html
      form_for-post-empty-textarea_defaults.html
      form_for-post-empty-submit.html
      form_for-post-empty-submit_defaults.html
      form_for-post-users-group_input_textarea_submit.html
    ]

    @fixture_files.each do |file|
      key = file.match(/(.+)\.html?$/)[1]
      @form_for_html[key] = fixture_load(file)
    end
  end

  def test_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_empty
    html_assert_equal @form_for_html['form_for-post-empty'], HexletCode.form_for(@user)
    html_assert_equal @form_for_html['form_for-post-users-empty'], HexletCode.form_for(@user, url: '/users')
  end

  def test_form_for_input
    html_assert_equal(@form_for_html['form_for-post-empty-input']) { HexletCode.form_for(@user) { |f| f.input :name } }

    html_assert_equal(@form_for_html['form_for-post-empty-input_add_class']) do
      HexletCode.form_for(@user, url: '#') { |f| f.input :name, class: 'user-input' }
    end
  end

  def test_form_for_textarea
    html_assert_equal(@form_for_html['form_for-post-empty-textarea']) do
      HexletCode.form_for @user, url: '#' do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
    end

    html_assert_equal(@form_for_html['form_for-post-empty-textarea_defaults']) do
      HexletCode.form_for(@user) { |f| f.input :job, as: :text }
    end
  end

  def test_form_for_submit
    [['form_for-post-empty-submit_defaults', nil],
     %w[form_for-post-empty-submit Wow]].each do |(key, value)|
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
    html_assert_equal(@form_for_html['form_for-post-users-group_input_textarea_submit']) do
      HexletCode.form_for(user, url: '/users') do |f|
        f.input :name
        f.input :job, as: :text
        f.submit 'Wow'
      end
    end
  end
end
