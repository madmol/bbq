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
      t("activerecord.attributes.user.#{field_name}") + " #{object.errors.messages[field_name].join(", ")}"
    end
  end

  def user_avatar(user)
    if user.avatar?
      user.avatar.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def user_avatar_thumb(user)
    if user.avatar.file.present?
      user.avatar.thumb.url
    else
      asset_pack_path('media/images/user.png')
    end
  end

  def event_photo(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.url
    else
      asset_pack_path('media/images/event.jpg')
    end
  end

  def event_thumb(event)
    photos = event.photos.persisted

    if photos.any?
      photos.sample.photo.thumb.url
    else
      asset_pack_path('media/images/event_thumb.jpg')
    end
  end

  def yandex_api_key
    "https://api-maps.yandex.ru/2.1/?apikey=#{Rails.application.credentials[:YANDEX_API_KEY]}&lang=ru_RU"
  end

  def photo_delete(photo)
    if current_user_can_edit?(photo)
      link_to (fa_icon "trash-alt"), event_photo_path(photo.event, photo), method: :delete, data: {confirm: t('are_you_sure')}
    end
  end
end

