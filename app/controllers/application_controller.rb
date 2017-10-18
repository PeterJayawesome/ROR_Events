class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :no_session?
  def current_user
  	User.find(session[:user_id]) if session[:user_id]
  end
  def all_states
  	State.all
  end
  helper_method :current_user,:all_states
  def no_session?
  	if not session[:user_id]
  		redirect_to "/sessions/new"
  	end
  end
end
