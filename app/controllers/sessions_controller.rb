class SessionsController < ApplicationController
	skip_before_action :no_session?,only: [:new,:create]
  def new
  end
  
  def create
  	user = User.find_by_email(params[:email]).try(:authenticate,params[:password])
  	if user
  		session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors] = ["Invalid Combination!"]
  		redirect_to "/sessions/new"
  	end
  end

  def delete
  	session[:user_id] = nil
  	redirect_to "/sessions/new"
  end
end
