class ShareInfosController < ApplicationController
#  before_filter :authenticate
  # GET /share_infos
  # GET /share_infos.json
  def index
    @user = user_session.current_user()
    login_first() unless @user
    @share_infos = @user.shares
    @recieve_infos = @user.recieves
  end

  # GET /share_infos/1
  # GET /share_infos/1.json
  def show
    @share_info = ShareInfo.find(params[:id])
  end

  # GET /share_infos/new
  # GET /share_infos/new.json
  def new
    @share_info = ShareInfo.new
  end

  # GET /share_infos/1/edit
  def edit
    @share_info = ShareInfo.find(params[:id])
  end

  # POST /share_infos
  # POST /share_infos.json
  def create
    @share_info = ShareInfo.new(params[:share_info])

    respond_to do |format|
      if @share_info.save
        format.html { redirect_to @share_info, :notice => 'Share info was successfully created.' }
        format.json { render :json => @share_info, :status => :created, :location => @share_info }
      else
        format.html { render :action => "new" }
        format.json { render :json => @share_info.errors, :status => :unprocessable_entity }
      end
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
    unless user_session.is_user?()
      flash[:error] = "Sorry, pal, you really need to login to access this page" 
      redirect_to(gate_path)
    end
  end
end
