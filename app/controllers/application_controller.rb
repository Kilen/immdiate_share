class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user, :authenticate, :get_unread_system_message

  def user_session
    return @user_session ||= UserSession.new(session)
  end

  def current_user
    return user_session.current_user()
  end
  
  def login_first
    flash[:error] = "Sorry, you have to login to access this page"
    session[:original_uri] = request.original_fullpath
    my_redirect(gate_path)
  end
  
  def get_current_user
    @current_user = current_user
  end

  def get_unread_system_message
    @unread_system_messages = @current_user.system_message_recieveds.find(:all,:order=>"created_at DESC")
    @unread_system_messages = @unread_system_messages.reject  do |msg| 
      msg.is_read? == true
    end
  end

  def is_request_from_plugin?
    if params[:request_from] == "plugin" || session[:plugin_redirection]
      session[:plugin_redirection] = nil
      return true
    else
      return false
    end
  end

  private

  def authenticate
    login_first() unless user_session.is_user?
  end
  def my_render option_for_plugin=nil, option_for_usual_request={}
    if is_request_from_plugin?()
      render(option_for_plugin, :layout=>false)
    else
      if option_for_usual_request[:is_redirect]
        redirect_to(option_for_usual_request[:url])
      else
        render(option_for_usual_request[:url])
      end
    end
  end

  #only use when failed to do something, like share something
  def my_redirect url 
    session[:plugin_redirection] = true if is_request_from_plugin?()
    redirect_to(url)
  end
end
