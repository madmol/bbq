class EventMailer < ApplicationMailer
  def subscription(subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = subscription.event

    mail to: @event.user.email, subject: default_i18n_subject(title: @event.title)
  end

  def comment(comment, email)
    @comment = comment
    @event = comment.event

    mail to: email, subject: default_i18n_subject(title: @event.title)
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo.photo

    @photo_url = photo.photo.url
    @photo_thumb_url = photo.photo.thumb.url
    @name = photo.user.name
    mail to: email, subject: default_i18n_subject(title: @event.title)
  end
end
