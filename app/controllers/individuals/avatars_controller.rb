class Individuals::AvatarsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message
  #(in application_controller)
 
  def edit
    @user = User.find_by_id(params[:id])
    if @user != @current_user
      flash[:error] = "you do not have the authority to modify this page"
      redirect_to(:back)
    end
  rescue ActionController::RedirectBackError
    redirect_to(individual_path(@current_user))
  end

  def update
    @user = User.find_by_id(params[:id])
    if @user == @current_user && @user.update_attributes(params[:user])
      flash[:success] = "update avatar successfully"
      redirect_to(individual_path(@user))
    else
      flash[:error] = "failed to update your avatar, please try again"
      render(:action=>"edit")
    end
  end

end
