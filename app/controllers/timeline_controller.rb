class TimelineController < ApplicationController
  def show
    if user_signed_in?
      @status = Status.new
    else
      render text: '', layout: 'guest'
    end
  end
  
  def statuses
    @statuses = current_user.remote_timeline(params[:max_id].to_s.presence)
    render template: 'users/statuses'
  end
  
  def recents
    @recents = current_user.remote_recents
  end
end
