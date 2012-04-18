class Admin::UsersController < ApplicationController
  before_filter :authenticate
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # put/users/1/change_admin
  def change_admin
    @user = User.find(params[:id])
    if @user
      @user.is_admin = @user.is_admin ? false : true
      if @user.save
        flash[:notice] = "change successfully"
      else
        flash[:error] = "failed to change admin of this user"
      end
    else
      flash[:error] = "failed to find this user" 
    end
    redirect_to(:action => "index")
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private

  def authenticate
    unless user_session.is_admin?()
      flash[:error] = "Sorry, pal, you have to be admin to scan this page, perhaps you may want to user your admin account to log in"
      session[:original_url] = request.url
      redirect_to(gate_path)
    end
  end
end
