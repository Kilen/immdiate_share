class FriendshipsController < ApplicationController
  # GET /friendships
  # GET /friendships.json
  def index
    @user = User.all
    login_first() unless @current_user
  end

  # POST /friendships
  # POST /friendships.json
  def create
    login_first() unless @current_user
    friendship = @current_user.friendships.build(:friend_id => \
                                                 params[:friend_id])
    if friendship.save()
      flash[:success] = "Add friends successfully added"
    else
      flash[:error] = "failed to add"
    end
    redirect_to(friendships_path)
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    login_first() unless @current_user
    @friendship = @current_user.friendships.find(params[:id])
    if @friendship.destroy
      flash[:success] = "This relationship has been deleted"
    else
      flash[:error] = "Delete failed, if you really want, please try again"
    end
    redirect_to(individual_path(@current_user))
  end
end
