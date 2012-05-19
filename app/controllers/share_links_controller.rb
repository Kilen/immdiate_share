class ShareLinksController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  def new
    @share_link = ShareLink.new
  end

  def create
    @share_link = ShareLink.new(params[:share_link])
    if ShareInfo.put_in_envolope(@share_link, @current_user, 
                                 params[:friend_ids], "link")
      flash[:success] = "successfully shared with your friends"
      redirect_to(share_infos_path+"#share_by_you")
    else
      flash[:error] = "faild to share with your friends, please try again"
      render(links_path)
    end
  end
end
