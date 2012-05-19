require 'test_helper'

class ShareInfos::ShareVideosControllerTest < ActionController::TestCase
  setup do
    @share_infos_share_video = share_infos_share_videos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:share_infos_share_videos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create share_infos_share_video" do
    assert_difference('ShareInfos::ShareVideo.count') do
      post :create, :share_infos_share_video => @share_infos_share_video.attributes
    end

    assert_redirected_to share_infos_share_video_path(assigns(:share_infos_share_video))
  end

  test "should show share_infos_share_video" do
    get :show, :id => @share_infos_share_video
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @share_infos_share_video
    assert_response :success
  end

  test "should update share_infos_share_video" do
    put :update, :id => @share_infos_share_video, :share_infos_share_video => @share_infos_share_video.attributes
    assert_redirected_to share_infos_share_video_path(assigns(:share_infos_share_video))
  end

  test "should destroy share_infos_share_video" do
    assert_difference('ShareInfos::ShareVideo.count', -1) do
      delete :destroy, :id => @share_infos_share_video
    end

    assert_redirected_to share_infos_share_videos_path
  end
end
