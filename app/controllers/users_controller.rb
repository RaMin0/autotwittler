class UsersController < ApplicationController
  before_action :authenticate_user!
  
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
    @statuses = current_user.remote_user_timeline(params[:user_id])
  end
  
  def search
    @users = current_user.remote_search(params[:q])
  end
end
