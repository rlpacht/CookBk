class UsersController < ApplicationController

  def new
    @user = User.new

    render :new
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.create(user_params)
    login(@user)
    redirect_to "/recipes"
    # render json: {user: @user}
  end

  def show
    @user = User.find(params[:id])
  end
end
