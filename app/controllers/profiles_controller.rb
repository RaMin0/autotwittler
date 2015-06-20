class ProfilesController < ApplicationController
  prepend_before_action :authenticate_user!
  
  def show
    @user = current_user.remote_user
    @status = Status.new
    
    render template: 'users/show'
  end
  
  def update
    if current_user.update(user_params)
      redirect_to profile_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end
  
protected
  
  def user_params
    params.require(:user).permit(:name, :description, :url)
  end
end
