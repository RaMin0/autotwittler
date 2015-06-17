class TimelineController < ApplicationController
  def index
    if user_signed_in?
      @status = Status.new
      @timeline = current_user.remote_timeline
      @suggested_users = current_user.remote_suggestions
    else
      render template: 'timeline/guest'
    end
  end
end
