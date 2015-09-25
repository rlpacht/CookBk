class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:name, :email, :password)
    @user = User.create(user_params)
    login(@user)
    redirect_to "/users/#{@user.id}"
  end

  def show
    @user = User.find(params[:id])
  end
end
