require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", about_path
  end

  test "visit signup page and check title" do
    get signup_path
    assert_template('users/new')
    assert_select("title", full_title("Sign up"))
  end
end