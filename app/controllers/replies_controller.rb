class RepliesController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /replies/new
  # GET /replies/new.json
  def new
    @reply = Reply.new
    @target_type = params[:target_type]
    @comment = get_target_comment(params[:comment_id], @target_type)
    redirect_back_unless(@comment)
  end

  # POST /replies
  # POST /replies.json
  def create
    @reply = Reply.new(params[:reply])
    @reply.user_id = @current_user.id
    parent_id = get_parent_id(params[:target_type], params[:comment][:id])
    @reply_target_id = params[:comment][:id]
    @reply.comment_id = parent_id 
    if is_valid_comment_id?(params[:comment],params[:target_type]) && \
      @reply.save()
      flash[:success] = "reply successfully"
      SystemMessage.create_message(@current_user.id, 
                                   params[:comment][:user_id].to_i,
                                   "reply")
      respond_to do |format|
        format.html {redirect_to(share_infos_path)}
        format.js {render(:layout=>false)}
      end
    else
      flash[:error] = "failed to reply"
      @comment = get_target_comment(params[:comment_id],params[:target_type])
      @no_reply = true
      redirect_back_unless(@comment)
    end
  end

  private

  def is_valid_comment_id? target_comment, target_type
    expected_comment = get_target_comment(target_comment[:id],target_type)
    if expected_comment && \
      expected_comment.user_id==target_comment[:user_id].to_i
      return true
    end
    return false
  end
  def get_target_comment target_comment_id, target_type
    if target_type == "comment"
      target_comment = Comment.find_by_id(target_comment_id)
    else
      target_comment = Reply.find_by_id(target_comment_id)
    end
    return target_comment
  end
  def redirect_back_unless condition
    respond_to do |format|
      unless condition
        flash[:error] = "invalid comment id, please try again"
        format.html {redirect_to(:back)}
        format.js {render(:js => "alert(#{flash[:error]})")}
      else
        format.html {render(:action=>"new")}
        format.js {render(:layout=>false, :action=>"new")}
      end
    end
  end
  def get_parent_id target_type, comment_id
    parent_id = comment_id
    if target_type == "reply"
      reply = Reply.find_by_id(comment_id)
      parent_id = reply.comment.id
    end
    return parent_id
  end
end
