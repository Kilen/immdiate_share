class GateController < ApplicationController
  def index
    @user = User.new()
  end

  def login
    if is_user?(params[:user])
      flash[:success] = "welcome, #{params[:user][:name]}"
      user_session.hello(params[:user][:name])
      uri = session[:original_uri] || root_path()
      redirect_to(uri)
    else
      flash[:error] = "the combination of name and password error"
      render(gate_path)
    end
  end

  def logout
    user_session.bye()
    flash[:notice] = "Looking forward to see you next time!"
    redirect_to(gate_path)
  end

  def register
    @user = User.new()
  end

  def create
    @user = User.new(params[:user])
    if @user && @user.save()
      user_session.hello(@user.name)
      flash[:success] = "Welcome, #{@user.name}"
      redirect_to(root_path)
    else
      render(register_path)
    end
  end

  private

  def is_user?(person)
    if User.authenticate?(person[:name],person[:password])
      return true
    else
      return false
    end
  end

end
