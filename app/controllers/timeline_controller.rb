class TimelineController < ApplicationController
  def show
    if user_signed_in?
      @status = Status.new
    else
      render text: '', layout: 'guest'
    end
  end
  
  def statuses
    @timeline = current_user.remote_timeline
  end
  
  def recents
    @recents = current_user.remote_recents
  end
end
