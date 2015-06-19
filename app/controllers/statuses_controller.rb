class StatusesController < ApplicationController
  before_action :authenticate_user!
  
  respond_to :html, :json
  
  def index
    @user = current_user.remote_user(params[:user_id])
    @statuses = current_user.remote_user_timeline(@user)
  end
  
  def create
    @status = Status.new(status_params)
    @status.user = current_user
    @status.save
    
    respond_with @status
  end
  
protected
  
  def status_params
    params.require(:status).permit(:text)
  end
end
