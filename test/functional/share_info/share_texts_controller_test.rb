require 'test_helper'

class ShareInfo::ShareTextsControllerTest < ActionController::TestCase
  setup do
    @share_info_share_text = share_info_share_texts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:share_info_share_texts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create share_info_share_text" do
    assert_difference('ShareInfo::ShareText.count') do
      post :create, :share_info_share_text => @share_info_share_text.attributes
    end

    assert_redirected_to share_info_share_text_path(assigns(:share_info_share_text))
  end

  test "should show share_info_share_text" do
    get :show, :id => @share_info_share_text
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @share_info_share_text
    assert_response :success
  end

  test "should update share_info_share_text" do
    put :update, :id => @share_info_share_text, :share_info_share_text => @share_info_share_text.attributes
    assert_redirected_to share_info_share_text_path(assigns(:share_info_share_text))
  end

  test "should destroy share_info_share_text" do
    assert_difference('ShareInfo::ShareText.count', -1) do
      delete :destroy, :id => @share_info_share_text
    end

    assert_redirected_to share_info_share_texts_path
  end
end
