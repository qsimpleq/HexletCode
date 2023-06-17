# frozen_string_literal: true

require 'test_helper'

class HexletCodeTest < Minitest::Test
  User = Struct.new(:name, :job, :gender, keyword_init: true)

  def setup
    @user = User.new(name: 'rob', job: 'hexlet', gender: 'm')

    @test_form_for_empty = fixture_load('form_for-post-empty.html')
    @test_form_for_empty_users = fixture_load('form_for-post-users-empty.html')
    @test_form_for_input = fixture_load('form_for-post-empty-input.html')
    @test_form_for_input_add_class = fixture_load('form_for-post-empty-input_add_class.html')
    @test_form_for_textarea = fixture_load('form_for-post-empty-textarea.html')
    @test_form_for_textarea_defaults = fixture_load('form_for-post-empty-textarea_defaults.html')
    @test_form_for_submit = fixture_load('form_for-post-empty-submit.html')
    @test_form_for_submit_defaults = fixture_load('form_for-post-empty-submit_defaults.html')
    @test_form_for_group = fixture_load('form_for-post-users-group_input_textarea_submit.html')
  end

  def test_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_form_for_empty
    html_assert_equal @test_form_for_empty, HexletCode.form_for(@user)
    html_assert_equal @test_form_for_empty_users, HexletCode.form_for(@user, url: '/users')
  end

  def test_form_for_input
    html_assert_equal(@test_form_for_input) { HexletCode.form_for(@user) { |f| f.input :name } }

    html_assert_equal(@test_form_for_input_add_class) do
      HexletCode.form_for(@user, url: '#') { |f| f.input :name, class: 'user-input' }
    end
  end

  def test_form_for_textarea
    html_assert_equal(@test_form_for_textarea) do
      HexletCode.form_for @user, url: '#' do |f|
        f.input :job, as: :text, rows: 50, cols: 50
      end
    end

    html_assert_equal(@test_form_for_textarea_defaults) do
      HexletCode.form_for(@user) { |f| f.input :job, as: :text }
    end
  end

  def test_form_for_submit
    [
      [@test_form_for_submit, 'Wow'],
      [@test_form_for_submit_defaults, nil]
    ].each do |(key, value)|
      html_assert_equal(key) do
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
    html_assert_equal(@test_form_for_group) do
      HexletCode.form_for(user, url: '/users') do |f|
        f.input :name
        f.input :job, as: :text
        f.submit 'Wow'
      end
    end
  end
end
