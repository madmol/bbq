class EventMailerJob < ApplicationJob
  queue_as :default

  def perform(event, model, author = false)
    method_name = model.class.to_s.downcase
    if author == false
      EventMailer.send(method_name, event, model).deliver_later
    else
      Event.subscribers_mailing_list(event, author).each do |email|
        EventMailer.send(method_name, event, model, email).deliver_later
      end
    end
  end
end
