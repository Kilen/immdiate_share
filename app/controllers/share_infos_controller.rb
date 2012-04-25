class ShareInfosController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_unread_system_message
  #(in application_controller)

  # GET /share_infos
  # GET /share_infos.json
  def index
    @share_infos = @current_user.shares
    @recieve_infos = @current_user.recieves
  end

  # GET /share_infos/new
  # GET /share_infos/new.json
  def new
    @share_info = ShareInfo.new
  end
  
  # POST /share_infos
  # POST /share_infos.json
  def create
    share_info = params[:share_info]
    @share_info = ShareInfo.new(share_info)
    @share_info.from_user = @current_user
    @share_info.send_to_friends(@current_user, params[:friend_ids])
    if @share_info.save()
      flash[:success] = "successfully shared with your friends"
      create_share_messages_to_friends(@current_user.id, params[:friend_ids])
      redirect_to(share_infos_path)
    else
      flash[:error] = "faild to share with your friends"
      render(new_text_path)
    end
  end

  private

  def create_share_messages_to_friends current_user_id, friend_ids
    friend_ids.each do |friend_id|
      SystemMessage.create_message(@current_user.id, friend_id.to_i,
                                   "share")
    end
  end
end
