class EventsController < ApplicationController

  def show
  	@event = Event.find_by_id(params[:id])
  	if not @event
  		redirect_to "/events"
  	end
  	@comments = @event.comments
  	@users = @event.users
  end

  def index
  	@events = current_user.state.events.includes(:user)
  	@user = current_user
  	@others = Event.includes(:user).where("state_id != ?", current_user.state_id)
  	@states = State.all
  end

  def edit
  	@event = Event.find_by_id(params[:id])
  	@user = current_user
  	if not @event or @user != @event.user
  		redirect_to "/events"
  	end
  end

  def create
  	event = Event.new(create_params)
  	if not event.save
  		flash[:errors] = event.errors.full_messages
  	end
	redirect_to "/events"
  end

  def update
  	event = Event.find_by_id(params[:id])
  	if event.user != current_user
  		redirect_to "/events"
  	end
  	if event.update(update_params)
  		flash[:errors] = ["Update successfully"]
  	else
  		flash[:errors] = event.errors.full_messages
  	end
  	redirect_to "/events/#{params[:id]}/edit"
  end

  def destroy
  	event = Event.find_by_id(params[:id])
  	if event and current_user.events.include?(event)
  		event.destroy
  	end
  	redirect_to "/events"
  end

  def join
  	join = current_user.joins.find_by(event_id:params[:id])
  	if not join
  		current_user.joins.create(event_id:params[:id])
  	end
  	redirect_to :back
  end

  def cancel
  	join = current_user.joins.find_by(event_id:params[:id])
  	if join
  		join.delete
  	end
  	redirect_to :back
  end

  private
  def create_params
  	params.require(:event).permit(:name,:date,:location,:state_id).merge(user:current_user)
  end
  def update_params
	params.require(:event).permit(:name,:date,:location,:state_id)  	
  end
end
