require 'test_helper'

class FlatsControllerTest < ActionController::TestCase
  setup do
    @flat = flats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:flats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create flat" do
    assert_difference('Flat.count') do
      post :create, flat: { description: @flat.description, geocode_lat: @flat.geocode_lat, geocode_long: @flat.geocode_long, nickname: @flat.nickname, postcode: @flat.postcode }
    end

    assert_redirected_to flat_path(assigns(:flat))
  end

  test "should show flat" do
    get :show, id: @flat
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @flat
    assert_response :success
  end

  test "should update flat" do
    put :update, id: @flat, flat: { description: @flat.description, geocode_lat: @flat.geocode_lat, geocode_long: @flat.geocode_long, nickname: @flat.nickname, postcode: @flat.postcode }
    assert_redirected_to flat_path(assigns(:flat))
  end

  test "should destroy flat" do
    assert_difference('Flat.count', -1) do
      delete :destroy, id: @flat
    end

    assert_redirected_to flats_path
  end
end
