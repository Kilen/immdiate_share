require 'test_helper'

class ShareInfosControllerTest < ActionController::TestCase
  setup do
    @share_info = share_infos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:share_infos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create share_info" do
    assert_difference('ShareInfo.count') do
      post :create, :share_info => @share_info.attributes
    end

    assert_redirected_to share_info_path(assigns(:share_info))
  end

  test "should show share_info" do
    get :show, :id => @share_info
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @share_info
    assert_response :success
  end

  test "should update share_info" do
    put :update, :id => @share_info, :share_info => @share_info.attributes
    assert_redirected_to share_info_path(assigns(:share_info))
  end

  test "should destroy share_info" do
    assert_difference('ShareInfo.count', -1) do
      delete :destroy, :id => @share_info
    end

    assert_redirected_to share_infos_path
  end
end
