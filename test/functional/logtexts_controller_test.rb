require 'test_helper'

class LogtextsControllerTest < ActionController::TestCase
  setup do
    @logtext = logtexts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logtexts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logtext" do
    assert_difference('Logtext.count') do
      post :create, logtext: { eventtype: @logtext.eventtype, msg: @logtext.msg }
    end

    assert_redirected_to logtext_path(assigns(:logtext))
  end

  test "should show logtext" do
    get :show, id: @logtext
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logtext
    assert_response :success
  end

  test "should update logtext" do
    put :update, id: @logtext, logtext: { eventtype: @logtext.eventtype, msg: @logtext.msg }
    assert_redirected_to logtext_path(assigns(:logtext))
  end

  test "should destroy logtext" do
    assert_difference('Logtext.count', -1) do
      delete :destroy, id: @logtext
    end

    assert_redirected_to logtexts_path
  end
end
