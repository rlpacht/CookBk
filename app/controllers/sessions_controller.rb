class SessionsController < ApplicationController

	def new
		@user = User.new()
	end

	def create
		user_params = params.require(:user).permit(:email, :password)
		@user = User.confirm(user_params)
		if @user
			login(@user)
			redirect_to "/recipes"
			# render json: {}
		else
			head 403
		end

	end

	def destroy
		logout
	end

end
