class CommentsController < ApplicationController
  before_filter :authenticate
  # GET /comments/new
  # GET /comments/new.json
  def new
    @comment = Comment.new()
    @share_info = ShareInfo.find(params[:share_info_id])
    unless @share_info
      flash[:error] = "comment error, no such id for share"
      redirect_to(:back)
    end
  end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(params[:comment])
    @comment.author = @current_user
    @comment.share_info_id = params[:share_info][:id]
    if is_share_info_id_valid?(params[:share_info]) && @comment.save()
      flash[:success] = "comment successfully"
      redirect_to(share_infos_path)
    else
      flash[:error] = "failed to comment, please try again"
      @share_info = ShareInfo.find_by_id(params[:share_info][:id])
      unless @share_info
        flash[:error] = "Invalid share info id"
        redirect_to(share_infos_path)
      end
      render(:action=>"new")
    end
  end

  private

  def authenticate
    login_first() unless user_session.is_user?
  end
  def is_share_info_id_valid? target_share
    expected_share = ShareInfo.find_by_id(target_share[:id])
    if expected_share && target_share[:from] == expected_share.from.to_s
      return true
    end
    return false
  end
end
