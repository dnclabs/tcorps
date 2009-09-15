  module ComatoseAdminMixin
    include Authentication
    def self.included(base)
      base.skip_before_filter :load_sidebar
      base.before_filter :require_login
      base.before_filter :require_manager

      base.helper_method :logged_in?
      base.helper_method :current_user
      base.helper_method :current_session
    end
  end

