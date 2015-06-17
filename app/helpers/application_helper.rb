module ApplicationHelper
  include Twitter::Autolink
  
  def twitter_text(text)
    auto_link(text,
      username_url_block: ->(username) { user_path(username) }
    ).html_safe
  end
  
  def flash_messages
    %w(notice alert).map do |flash_message_type|
      flash_message_type = flash_message_type.to_sym
      flash_message      = flash[flash_message_type]
      flash.delete(flash_message_type)

      %Q{
        <div class="alert alert-#{flash_message_type_css_class(flash_message_type)}">
          <!-- <button type="button" class="close" data-close="alert"></button> -->
          <span>#{flash_message}</span>
        </div>
      } if flash_message
    end.join.html_safe
  end

  def flash_message_type_css_class(flash_message_type)
    case flash_message_type
    when :notice then 'success'
    when :alert  then 'danger'
    end
  end

  def error_messages(f)
    f.error_messages header_message: nil, class: 'alert alert-danger'
  end
end
