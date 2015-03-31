require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "should get currimage" do
    get :currimage
    assert_response :success
  end

  test "should get techinfo" do
    get :techinfo
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

end
