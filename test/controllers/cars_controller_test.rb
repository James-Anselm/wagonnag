require 'test_helper'

class CarsControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
  end

  test "should redirect new when not logged in" do
    get :new
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should load ok with logged in user" do
    log_in_as @user
    get :new
    assert_response :success
  end

end
