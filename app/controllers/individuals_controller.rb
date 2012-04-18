class IndividualsController < ApplicationController
  # GET /individuals/1
  # GET /individuals/1.json
  def show
    login_first() unless @current_user
    @friendships = @current_user.friendships
  end

  # GET /individuals/1/edit
  def edit
    login_first() unless @current_user
  end


  # PUT /individuals/1
  # PUT /individuals/1.json
  def update
    login_first() unless @current_user
    if @current_user.update_attributes(params[:user])
      flash[:success] = "profile was successfully updated"
      redirect_to individual_path(@current_user.id)
    else
      flash[:error] = "update error, please try again"
      render(:action => "edit")
    end
  end
end
