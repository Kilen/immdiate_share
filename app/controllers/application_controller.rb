class ApplicationController < ActionController::Base
  protect_from_forgery

  def user_session
    return @user_session ||= UserSession.new(session)
  end
end
