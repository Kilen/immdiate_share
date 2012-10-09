class ShareInfos::ShareTextsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /share_info/share_texts/new
  # GET /share_info/share_texts/new.json
  def new
    @share_text = ShareText.new
    my_render();
  end
  def create
    @share_text = ShareText.new(params[:share_text])
    if ShareInfo.put_in_envolope(@share_text, @current_user, 
                                 params[:friend_ids], "text")
      flash[:success] = "successfully shared with your friends"
      my_render({:text=>flash[:success]}, 
                {:redirect_to=>true, :url=>share_infos_path+"#share_by_you"})
    else
      flash[:error] = "faild to share with your friends, please try again"
      my_render(new_text_path, {:url=>new_text_path})
    end
  end
end
