class ShareInfos::ShareTextsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /share_info/share_texts/new
  # GET /share_info/share_texts/new.json
  def new
    @share_text = ShareText.new
  end
  def create
    @share_text = ShareText.new(params[:share_text])
    if ShareInfo.put_in_envolope(@share_text, @current_user, 
                                 params[:friend_ids], "text")
      flash[:success] = "successfully shared with your friends"
      redirect_to(share_infos_path+"#share_by_you")
    else
      flash[:error] = "faild to share with your friends, please try again"
      render(texts_path)
    end
  end
end
