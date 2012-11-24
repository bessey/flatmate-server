require 'test_helper'

class ShopItemsControllerTest < ActionController::TestCase
  setup do
    @shop_item = shop_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:shop_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create shop_item" do
    assert_difference('ShopItem.count') do
      post :create, shop_item: { flat_id: @shop_item.flat_id, name: @shop_item.name, paid_back: @shop_item.paid_back, price: @shop_item.price, user_bought_id: @shop_item.user_bought_id, user_want_id: @shop_item.user_want_id }
    end

    assert_redirected_to shop_item_path(assigns(:shop_item))
  end

  test "should show shop_item" do
    get :show, id: @shop_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @shop_item
    assert_response :success
  end

  test "should update shop_item" do
    put :update, id: @shop_item, shop_item: { flat_id: @shop_item.flat_id, name: @shop_item.name, paid_back: @shop_item.paid_back, price: @shop_item.price, user_bought_id: @shop_item.user_bought_id, user_want_id: @shop_item.user_want_id }
    assert_redirected_to shop_item_path(assigns(:shop_item))
  end

  test "should destroy shop_item" do
    assert_difference('ShopItem.count', -1) do
      delete :destroy, id: @shop_item
    end

    assert_redirected_to shop_items_path
  end
end
