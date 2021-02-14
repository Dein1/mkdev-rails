# frozen_string_literal: true

class EventCreator < ApplicationService
  def call(params, user)
    event = create_event(params, user)

    send_email(event) if event.save
    event
  end

  private

  def create_event(params, user)
    user.events.new(params)
  end

  def send_email(event)
    EventMailer.with(event: event).new_event_notification.deliver_later
  end
end
