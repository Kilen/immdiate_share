class CommentsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new()
    @share_info = ShareInfo.find(params[:share_info_id])
    redirect_back_unless(@share_info)
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.author = @current_user
    @comment.share_info_id = params[:share_info][:id]
    if is_share_info_id_valid?(params[:share_info]) && @comment.save()
      flash[:success] = "comment successfully"
      SystemMessage.create_message(@current_user.id, 
                                   params[:share_info][:from].to_i,
                                   "comment")
      redirect_to(share_infos_path)
    else
      flash[:error] = "failed to comment, please try again"
      @share_info = ShareInfo.find_by_id(params[:share_info][:id])
      redirect_back_unless(@share_info)
    end
  end

  private

  def is_share_info_id_valid? target_share
    expected_share = ShareInfo.find_by_id(target_share[:id])
    if expected_share && target_share[:from] == expected_share.from.to_s
      return true
    end
    return false
  end
  def redirect_back_unless condition
    unless condition
      flash[:error] = "Invalid share info id"
      redirect_to(share_infos_path)
    else
      render(:action=>"new")
    end
  end
end
