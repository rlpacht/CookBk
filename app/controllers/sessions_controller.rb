class SessionsController < ApplicationController

	def new
		if logged_in?
			redirect_to "/recipes"
		else
			@user = User.new()
			render :new
		end
	end

	def create
		user_params = params.require(:user).permit(:email, :password)
		@user = User.confirm(user_params)
		if @user
			login(@user)
			redirect_to "/recipes"
		else
			head 403
		end

	end

	def log_user_out
		if logged_in?
			destroy
			redirect_to "/sessions/new"
		end
	end

	def destroy

		logout
		redirect_to action: "new"
	end

end