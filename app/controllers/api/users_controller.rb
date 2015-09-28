class Api::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    user_params = params.require(:user).permit(:email, :password)
    @user = User.create(user_params)
    login(@user)
    render json: {}
  end

  def show
    @user = User.find(params[:id])
  end
end
