class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def index
    if current_user.twitter_uid.in?(%w[69586833 3323417409])
      @users = User.all
    else
      redirect_to root_path
    end
  end
  
  def show
    if current_user.me?(params[:id])
      redirect_to profile_path
    else
      @user = current_user.remote_user(params[:id])
    end
  rescue Twitter::Error::NotFound => e
    redirect_to root_path, alert: "User not found: #{params[:id]}"
  end
  
  def statuses
    @statuses = current_user.remote_user_timeline(params[:user_id], params[:max_id].to_s.presence)
  end
  
  def search
    respond_to do |format|
      format.html { @users = current_user.remote_search(params[:q], 15) }
      format.json { @users = current_user.remote_search(params[:q], 6) }
    end
  end
end
