class UsersController < ApplicationController
	skip_before_action :no_session?,only: [:new,:reg_params]
  def edit
  	if params[:id].to_i != session[:user_id]
  		return redirect_to "/users/#{session[:user_id]}/edit"
  	end
  	@user = current_user 
  end

  def new
  	user = User.new(reg_params)
  	if user.save
  		session[:user_id] = user.id
  		redirect_to "/events"
  	else
  		flash[:errors] = user.errors.full_messages
  		redirect_to "/sessions/new"
  	end
  end

  def update
  	if params[:id].to_i != session[:user_id]
  		return redirect_to "/users/#{session[:user_id]}/edit"
  	end
  	user = User.find(params[:id])
  	if user.update(update_params)
  		flash[:errors] = ["Update successfully"]
  		return redirect_to "/events"
  	else
  		flash[:errors] = user.errors.full_messages
	  	redirect_to "/users/#{params[:id]}/edit"
  	end
  end

  private

  def reg_params
  	params.require(:user).permit(:first_name,:last_name,:email,:location,:state_id,:password,:password_confirmation)
  end

  def update_params
  	params.require(:user).permit(:first_name,:last_name,:email,:location,:state_id)  	
  end

end
