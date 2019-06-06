class ApplicationController < ActionController::Base

helper_method :current_user, :logged_in?


def current_user
	@current_user ||= User.find_by(sessin_tokin: session[:sessin_tokin])
end

def logged_in?
	!!current_user
end

def log_in_user!(user)
	session[:sessin_tokin] = user.reset_sessin_tokin!
end

def log_out!
	current_user.reset_sessin_tokin! if current_user
	session[:sessin_tokin] = nil
	@current_user = nil
end



end
