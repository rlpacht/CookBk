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

	def destroy
		logout
		@user = User.new()
		# respond_to do |format|
  #     format.html {redirect_to :action => :new, status: 303, notice: "You have been logged out"}
  #   end

		redirect_to :action => :new, status: 303
	end

end