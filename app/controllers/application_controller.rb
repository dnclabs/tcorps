# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all 
  protect_from_forgery
  filter_parameter_logging :password, :password_confirmation

  before_filter :load_sidebar

  include Authentication
  helper_method :logged_in?
  helper_method :current_user
  helper_method :current_session

  def load_sidebar
    @sidebar_campaigns = (logged_in? ? Campaign.active_for(current_user) : Campaign.active).all :limit => 5, :order => 'created_at DESC'
  end
  
  def remote_task_url(task, user)
    options = {
      :username => user.login,
      :task_key => task.key,
      :points => user.campaign_points(task.campaign)
    }
    "#{task.campaign.url}?#{query_string_for options}"
  end
  helper_method :remote_task_url
  
  def query_string_for(options = {})
    string = ""
    options.keys.each do |key|
      string << "&" unless key == options.keys.first
      string << "#{key}=#{CGI::escape options[key].to_s}"
    end
    string
  end
  helper_method :query_string_for
  
  def goto_path!
    goto = session[:goto]
    session[:goto] = nil
    goto
  end
  
  # clickpass
  def clickpass_register_url(user)
    params = {
      :requested_fields => 'nickname,email',
      :required_fields => 'nickname,email',
      :nickname_label => 'Login',
      :site_key => CLICKPASS_SITE_KEY,
      :site_name => 'TransparencyCorps',
      :process_openid_registration_url => process_openid_registration_url
    }
    if user.errors.on(:login)
      params[:nickname_error] = "Login #{[user.errors.on(:login)].flatten.join(', and ')}"
    end
    if user.errors.on(:email)
      params[:email_error] = "Email #{[user.errors.on(:email)].flatten.join(', and ')}"
    end
    
    "#{CLICKPASS_BASE_URL}?#{query_string_for params}"
  end
  
  def query_string_for(options = {})
    string = ""
    options.keys.each do |key|
      string << "&" unless key == options.keys.first
      string << "#{key}=#{CGI::escape options[key].to_s}"
    end
    string
  end
  
end