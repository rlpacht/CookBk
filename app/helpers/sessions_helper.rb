module SessionsHelper
	def login(user)
		session[:user_id] = user.id
		@current_user = user
	end

	def current_user
		# TODO uncomment this when user loggin and sign up is set up (issues with CSRF)
		# @current_user ||= User.find_by_id(session[:user_id])
		User.all.first
	end

	def logged_in?
		@current_user.nil?
	end

	def logout
		@current_user = session[:user_id] = nil
	end
end
