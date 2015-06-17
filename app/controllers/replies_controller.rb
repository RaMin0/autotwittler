class RepliesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @status = current_user.remote_status(params[:status_id])
    @parent_status = current_user.remote_status(@status.in_reply_to_status_id) if @status.in_reply_to_status_id.present?
    @reply = Reply.new
  end
  
  def create
    @reply = Reply.new(reply_params)
    @reply.user = current_user
    @reply.status_id = params[:status_id]
    
    if @reply.save
      redirect_to status_replies_path(@reply.tweet_id)
    else
      @status = current_user.remote_status(params[:status_id])
      render action: :new
    end
  end
  
protected
  
  def reply_params
    params.require(:reply).permit(:text)
  end
end
