class GateController < ApplicationController
  skip_before_filter :authenticate, :get_unread_system_message
  def index
    @user = User.new()
    my_render();
  end

  def login
    if is_user?(params[:user])
      flash[:success] = "welcome, #{params[:user][:name]}"
      user_session.hello(params[:user][:name])
      uri = session[:original_uri] || root_path()
      session[:original_uri] = nil
      my_render({:text=>flash[:success]},
                {:is_redirect=>true, :url=>uri})
    else
      flash[:error] = "the combination of name and password error"
      my_redirect(gate_path)
    end
  end

  def logout
    user_session.bye()
    flash[:notice] = "Looking forward to see you next time!"
    my_render({:text=>flash[:notice]},
              {:is_redirect=>true, :url=>gate_path})
  end

  def register
    @user = User.new()
    my_render()
  end

  def create
    @user = User.new(params[:user])
    if @user && @user.save()
      user_session.hello(@user.name)
      flash[:success] = "Welcome, #{@user.name}"
      my_render({:text=>flash[:success]},
                {:is_redirect=>true, :url=>root_path})
    else
      flash[:error] = "failed to register"
      my_render(register_path,{:url=>register_path})
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
