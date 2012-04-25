class IndividualsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message
  #(in application_controller)

  # GET /individuals/1
  # GET /individuals/1.json
  def show
    @friendships = @current_user.friendships
  end

  # GET /individuals/1/edit
  def edit
  end


  # PUT /individuals/1
  # PUT /individuals/1.json
  def update
    if @current_user.update_attributes(params[:user])
      flash[:success] = "profile was successfully updated"
      redirect_to individual_path(@current_user.id)
    else
      flash[:error] = "update error, please try again"
      render(:action => "edit")
    end
  end
end
