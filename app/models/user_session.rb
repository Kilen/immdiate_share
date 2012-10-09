class UserSession
  def initialize session
    @session ||= session
  end

  def hello user_name
    user = User.find_by_name(user_name)
    if user
      @session[:user_id] = user.id
    end
  end

  def bye
    @session[:user_id] = nil
  end

  def current_user
    return User.find_by_id(@session[:user_id])
  end

  def is_user?
    if @session[:user_id]
      return true
    else
      return false
    end
  end

  def is_admin?
    if @session[:user_id] && User.find_by_id(@session[:user_id]).is_admin?
      return true
    else
      return false
    end
  end
end
