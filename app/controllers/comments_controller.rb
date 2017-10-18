class CommentsController < ApplicationController
  def create
  	comment = Comment.new(content:params[:content],user:current_user,event:Event.find_by_id(params[:id]))
  	if comment.save
  		flash[:errors] = ["Comment seccessfully"]
  	else
  		flash[:errors] = comment.errors.full_messages
  	end
  	redirect_to :back
  end
end
