require 'test_helper'

class CpuTemperaturesControllerTest < ActionController::TestCase
  setup do
    @cpu_temperature = cpu_temperatures(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cpu_temperatures)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cpu_temperature" do
    assert_difference('CpuTemperature.count') do
      post :create, cpu_temperature: { temperature: @cpu_temperature.temperature, time: @cpu_temperature.time }
    end

    assert_redirected_to cpu_temperature_path(assigns(:cpu_temperature))
  end

  test "should show cpu_temperature" do
    get :show, id: @cpu_temperature
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cpu_temperature
    assert_response :success
  end

  test "should update cpu_temperature" do
    put :update, id: @cpu_temperature, cpu_temperature: { temperature: @cpu_temperature.temperature, time: @cpu_temperature.time }
    assert_redirected_to cpu_temperature_path(assigns(:cpu_temperature))
  end

  test "should destroy cpu_temperature" do
    assert_difference('CpuTemperature.count', -1) do
      delete :destroy, id: @cpu_temperature
    end

    assert_redirected_to cpu_temperatures_path
  end
end
