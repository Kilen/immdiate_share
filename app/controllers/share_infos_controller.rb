class ShareInfosController < ApplicationController 
  #before_filter :get_current_user, :authenticate, :get_unread_system_message
  #(in application_controller)

  # GET /share_infos
  # GET /share_infos.json
  def index
    @share_infos = @current_user.shares.find(:all,:order=>"created_at DESC")
    @recieve_infos = @current_user.recieves.find(:all,
                                                 :order=>"created_at DESC")
  end

  # GET /share_infos/new
  # GET /share_infos/new.json
  def new
    @share_info = ShareInfo.new
  end
  
end
