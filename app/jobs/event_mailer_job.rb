class EventMailerJob < ApplicationJob
  queue_as :default

  def perform(model, author = nil)
    case model.class.name
    when 'Photo'
      Event.subscribers_mailing_list(model.event, author).each do |email|
        EventMailer.photo(model, email).deliver_later
      end
    when 'Comment'
      Event.subscribers_mailing_list(model.event, author).each do |email|
        EventMailer.comment(model, email).deliver_later
      end
    when 'Subscription'
      EventMailer.subscription(model).deliver_later
    end
  end
end
