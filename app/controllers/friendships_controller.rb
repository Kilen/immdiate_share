class FriendshipsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message 
  #(in application_controller)

  # GET /friendships
  # GET /friendships.json
  def index
    @users = User.all
  end

  def ask_for_friendship
    friend = User.find_by_id(params[:id])
    if friend && \
      SystemMessage.create_message(@current_user.id, params[:id].to_i,
                                   "ask_friendship")
      flash[:notice] = "Please wait for #{friend.name}'s reply"
    else
      flash[:error] = "fail, please try again"
    end
    redirect_to(:back)
  end

  def agree_with_friendship
    friend = User.find_by_id(params[:id])
    if friend && create_friendship_with(friend.id)
      SystemMessage.create_message(@current_user.id, params[:id].to_i,
                                   "agree_friendship")
      SystemMessage.mark_message_read(params[:message_id])
      flash[:success] = "#{friend.name} is your friend now"
    else
      flash[:error] = "failed to add friend"
    end
    redirect_to(:back)
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = @current_user.friendships.find_by_id(params[:id])
    if @friendship.destroy
      flash[:success] = "This relationship has been deleted"
    else
      flash[:error] = "Delete failed, if you really want, please try again"
    end
    redirect_to(individual_path(@current_user))
  end

  def search
    @is_search_result = true
    @users = User.find(:all, 
              :conditions=>["users.name like ?", "%#{params[:user_name]}%"])
    flash[:original_uri] = request.original_fullpath
    render(:action => "index")
  end

  private

  def create_friendship_with friend_id
    friendship = @current_user.friendships.build(:friend_id => friend_id) 
    if friendship.save()
      return true
    else
      return false
    end
  end

end
