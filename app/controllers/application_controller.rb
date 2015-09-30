class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper

  def index
    if logged_in?
      render :index
    else
      redirect_to "/sessions/new"
    end
  end

  # def show
  #   if params[:route] == "recipes"
  #     redirect_to "/recipes"
  #   elsif params[:route] == "favorites"
  #     redirect_to "/favorites"
  #   elsif params[:route] == "destroy"
  #     redirect_to "/sessions/destroy"
  #   else
  #     binding.pry
  #   end
  # end
end
