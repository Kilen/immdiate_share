class ShareInfos::ShareImagesController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  def new
    @share_image = ShareImage.new
  end
  def upload
    @share_image = ShareImage.new
  end
  def show
    @share_image = ShareImage.find_by_id(params[:id])
    redirect_to new_share_image_path unless @share_image
  end
  def create
    @share_image = ShareImage.new(params[:share_image])
    if ShareInfo.put_in_envolope(@share_image, @current_user, 
                                 params[:friend_ids], "image")
      flash[:success] = "successfully shared with your friends"
      redirect_to(share_infos_path+"#share_by_you")
    else
      flash[:error] = "faild to share with your friends, please try again"
      last_uri = @share_image.from_where=="from_url" ? new_image_path : upload_path
      render(last_uri)
    end
  end
end
