class FollowshipsController < ApplicationController
  def create
    @user = current_user.remote_follow(params[:user_id])
  end
  
  def destroy
    @user = current_user.remote_unfollow(params[:user_id])
  end
end
