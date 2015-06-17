class StatusesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @user = current_user.remote_user(params[:user_id])
    @statuses = current_user.remote_user_timeline(@user)
  end
  
  def create
    @status = Status.new(status_params)
    @status.user = current_user
    
    if @status.save
      redirect_to status_replies_path(@status.id)
    else
      render action: :create
    end
  end
  
protected
  
  def status_params
    params.require(:status).permit(:text)
  end
end
