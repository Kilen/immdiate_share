class Individuals::TempsController < ApplicationController
  #before_filter :get_current_user, :authenticate, :get_system_message
  #(in application_controller)
 
  def new
    if @current_user.temp.blank?
      @temp = Temp.new
    else
      @temp = @current_user.temp
    end
  end

  def update
    @temp = Temp.find_by_id(params[:id])
    if @temp.user_id == @current_user.id && \
      @temp.update_attributes(params[:temp])
      flash[:success] = "update avatar successfully"
      redirect_to(individual_path(@current_user))
    else
      flash[:error] = "failed to update your avatar, please try again"
      redirect_to(:action=>"new")
    end
  end

  def create
    @temp = Temp.find_by_user_id(@current_user.id)
    @temp.delete if @temp
    @temp = Temp.new(params[:temp])
    @temp.user_id = @current_user.id
    respond_to do |format|
      if @temp.save()
        format.js do
          responds_to_parent do
            render :layout => false
          end
        end
      else
        format.js do
          responds_to_parent do
            render :js=>"$(\"<div class='alert-box error'>failed to update your avatar, please try again</div>\").prependTo('body');"
          end
        end
      end
    end
  end
end
