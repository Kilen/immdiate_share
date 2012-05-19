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
      respond_to do |format|
        format.html do
          location = @comment.share_info.from == @current_user.id ? \
            "#share_by_you" : "#share_from_friend"
          redirect_to(share_infos_path+location)
        end
        format.js {render(:layout=>false)}
      end
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
    respond_to do |format|
      unless condition
        flash[:error] = "Invalid share info id, please try again"
        format.html {redirect_to(share_infos_path)}
        format.js {render(:js => "alert(#{flash[:error]})")}
      else
        format.html {render(:action=>"new")}
        format.js {render(:layout=>false, :action=>"new")}
      end
    end
  end
end
