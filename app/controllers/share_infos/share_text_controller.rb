class ShareInfos::ShareTextController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /share_info/share_texts/new
  # GET /share_info/share_texts/new.json
  def new
    @share_info = ShareInfo.new
  end
end
