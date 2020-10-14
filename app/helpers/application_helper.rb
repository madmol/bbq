module ApplicationHelper
  #https://gist.github.com/suryart/7418454
  def bootstrap_class(flash_type)
    {
      success: "alert-success",
      error: "alert-danger",
      alert: "alert-warning",
      notice: "alert-info"
    }[flash_type.to_sym] || flash_type.to_s
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(
        content_tag(:div, message, class: "alert #{bootstrap_class(msg_type)}") do
          concat(
            content_tag(:button, "&times;".html_safe, class: "close", data: {dismiss: 'alert'}, aria: {hidden: true})
          )
          concat(message)
        end
      )
    end
    nil
  end

  def show_errors(object, field_name)
    if object.errors.messages[field_name].any?
      "#{field_name.to_s.humanize} #{object.errors.messages[field_name].join(", ")}"
    end
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end
end
