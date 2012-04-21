class ShareInfos::ShareTextController < ApplicationController
  # GET /share_info/share_texts
  # GET /share_info/share_texts.json
  def index
    @share_info_share_texts = ShareInfo::ShareText.all
  end

  # GET /share_info/share_texts/new
  # GET /share_info/share_texts/new.json
  def new
    @share_info = ShareInfo.new
  end
end
