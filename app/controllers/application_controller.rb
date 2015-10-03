class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  layout "application"
  def index
    if logged_in?
      render :index
    else
      redirect_to "/sessions/new"
    end
  end
end
