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
    redirect_to(gate_path)
  end
  
  def get_current_user
    @current_user = current_user
  end

  def get_unread_system_message
    @unread_system_messages = @current_user.system_message_recieveds
    @unread_system_messages = @unread_system_messages.reject  do |msg| 
      msg.is_read? == true
    end
  end

  private

  def authenticate
    login_first() unless user_session.is_user?
  end
end
