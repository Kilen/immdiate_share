class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :get_current_user

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
end
