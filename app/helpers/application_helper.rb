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
            content_tag(:button, 'x', class: "close", data: { dismiss: 'alert' })
          )
          concat(message)
        end
      )
    end
    nil
  end

  def user_avatar(user)
    asset_pack_path('media/images/user.png')
  end
end
