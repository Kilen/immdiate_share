class ShareInfos::ShareVideosController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /share_infos/share_videos/new
  # GET /share_infos/share_videos/new.json
  def new
    @share_video = ShareVideo.new
  end

  # POST /share_infos/share_videos
  # POST /share_infos/share_videos.json
  def create
    @share_video = ShareVideo.new(params[:share_video])
    if ShareInfo.put_in_envolope(@share_video, @current_user, 
                                 params[:friend_ids], "video")
      flash[:success] = "successfully shared with your friends"
      redirect_to(share_infos_path+"#share_by_you")
    else
      flash[:error] = "faild to share with your friends, please try again"
      render(new_video_path)
    end
  end
end
