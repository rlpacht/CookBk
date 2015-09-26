class Api::SessionsController < ApplicationController
	def create
		binding.pry
		user_params = params.require(:user).permit(:email, :password)
		@user = User.confirm(user_params)
		if @user
			login(@user)
		end
		render json: {}
	end

	def destroy
		logout
	end

end
