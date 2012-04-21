class ShareInfosController < ApplicationController
  before_filter :authenticate
  # GET /share_infos
  # GET /share_infos.json
  def index
    @share_infos = @current_user.shares
    @recieve_infos = @current_user.recieves
  end

  # GET /share_infos/new
  # GET /share_infos/new.json
  def new
    @share_info = ShareInfo.new
  end
  
  # POST /share_infos
  # POST /share_infos.json
  def create
    share_info = params[:share_info]
    @share_info = ShareInfo.new(share_info)
    @share_info.from_user = @current_user
    @share_info.send_to_friends(@current_user, params[:friend_ids])
    if @share_info.save()
      flash[:success] = "successfully shared with your friends"
      redirect_to(share_infos_path)
    else
      flash[:error] = "faild to share with your friends"
      render(new_text_path)
    end
  end

  # PUT /share_infos/1
  # PUT /share_infos/1.json
  def update
    @share_info = ShareInfo.find(params[:id])

    respond_to do |format|
      if @share_info.update_attributes(params[:share_info])
        format.html { redirect_to @share_info, :notice => 'Share info was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @share_info.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /share_infos/1
  # DELETE /share_infos/1.json
  def destroy
    @share_info = ShareInfo.find(params[:id])
    @share_info.destroy

    respond_to do |format|
      format.html { redirect_to share_infos_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate
    login_first() unless user_session.is_user?()
  end
end
