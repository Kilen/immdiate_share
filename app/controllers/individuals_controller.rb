class IndividualsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message
  #(in application_controller)

  # GET /individuals/1
  # GET /individuals/1.json
  def show
    if @current_user.id == params[:id].to_i
      @user = @current_user
    else
      @user = @current_user.friends.find_by_id(params[:id])
    end
    if @user
      @friendships = @user.friendships
    else
      flash[:error] = "you don't have such a friend"
      redirect_to(:back)
    end
  rescue ActionController::RedirectBackError
    redirect_to(root_path)
  end

  # GET /individuals/1/edit
  def edit
    unless @current_user.id == params[:id].to_i
      flash[:error] = "You do not have enough authority to edit this file"
    end
    @user = @current_user
  end


  # PUT /individuals/1
  # PUT /individuals/1.json
  def update
    if @current_user.id == params[:id].to_i && \
      @current_user.update_attributes(params[:user])
      flash[:success] = "profile was successfully updated"
      redirect_to individual_path(@current_user.id)
    else
      flash[:error] = "update error, please try again"
      @user = @current_user
      render(:action => "edit")
    end
  end
end
