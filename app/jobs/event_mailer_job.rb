class EventMailerJob < ApplicationJob
  queue_as :default

  def perform(model)
    case model
    when Photo
      model.event.subscribers_mailing_list(model.user&.email).each do |email|
        EventMailer.photo(model, email).deliver_later
      end
    when Comment
      model.event.subscribers_mailing_list(model.user&.email).each do |email|
        EventMailer.comment(model, email).deliver_later
      end
    when Subscription
      EventMailer.subscription(model).deliver_later
    end
  end
end
