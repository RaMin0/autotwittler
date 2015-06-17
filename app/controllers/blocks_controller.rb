class BlocksController < ApplicationController
  def create
    @user = current_user.remote_block(params[:user_id].to_i)
    redirect_to user_path(@user.screen_name)
  end
  
  def destroy
    @user = current_user.remote_unblock(params[:user_id].to_i)
    redirect_to user_path(@user.screen_name)
  end
end
