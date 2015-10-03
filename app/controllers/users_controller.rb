class UsersController < ApplicationController
  layout "application"
  def new
    if logged_in?
      redirect_to "/recipes"
    else
      @user = User.new
      render :new
    end
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.create(user_params)
    login(@user)
    redirect_to "/recipes"
  end

  def show
    @user = User.find(params[:id])
  end
end