module Authentication

  def included(base)
    puts base
    base.helper_method :logged_in?
    base.helper_method :current_user
    base.helper_method :current_session    
  end

  def require_login
    unless logged_in?
      session[:goto] = params[:goto] || request.path
      redirect_to register_path and return false
    end
  end

  def require_manager
    redirect_to root_path and return false unless current_user.manager? or current_user.admin?
  end

  def require_admin
    redirect_to root_path and return false unless current_user.admin?
  end

  def logged_in?
    !current_user.nil?
  end

  def current_user
    @current_user ||= current_session.user if current_session
  end

  def current_session
    @current_session ||= UserSession.find
  end
end