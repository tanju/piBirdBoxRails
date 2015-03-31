require 'test_helper'

class TuersensorsControllerTest < ActionController::TestCase
  setup do
    @tuersensor = tuersensors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tuersensors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tuersensor" do
    assert_difference('Tuersensor.count') do
      post :create, tuersensor: { movetype: @tuersensor.movetype, time: @tuersensor.time }
    end

    assert_redirected_to tuersensor_path(assigns(:tuersensor))
  end

  test "should show tuersensor" do
    get :show, id: @tuersensor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tuersensor
    assert_response :success
  end

  test "should update tuersensor" do
    put :update, id: @tuersensor, tuersensor: { movetype: @tuersensor.movetype, time: @tuersensor.time }
    assert_redirected_to tuersensor_path(assigns(:tuersensor))
  end

  test "should destroy tuersensor" do
    assert_difference('Tuersensor.count', -1) do
      delete :destroy, id: @tuersensor
    end

    assert_redirected_to tuersensors_path
  end
end
