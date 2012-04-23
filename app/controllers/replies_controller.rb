class RepliesController < ApplicationController
  before_filter :authenticate
  # GET /replies/new
  # GET /replies/new.json
  def new
    @reply = Reply.new
    @comment = Comment.find_by_id(params[:comment_id])
    @no_reply_link = true
    unless @comment
      flash[:error] = "error, no such comment id"
      redirect_to(:back)
    end
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply])
    @reply.user_id = @current_user.id
    @reply.comment_id = params[:comment][:id]
    if is_valid_comment_id?(params[:comment]) && @reply.save()
      flash[:success] = "reply successfully"
      redirect_to(share_infos_path)
    else
      flash[:error] = "failed to reply"
      @comment = Comment.find_by_id(params[:comment][:id])
      unless @comment
        flash[:error] = "invalid comment id"
        redirect_to(share_infos_path)
      end
      render(:action=>"new")
    end
  end

  private

  def authenticate
    login_first() unless user_session.is_user?
  end
  def is_valid_comment_id? target_comment
    expected_comment = Comment.find_by_id(target_comment[:id])
    if expected_comment && expected_comment.user_id==target_comment[:user_id]
      return true
    end
    return false
  end
end
