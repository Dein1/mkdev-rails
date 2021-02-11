# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/event_mailer
class EventMailerPreview < ActionMailer::Preview
  # Preview this email at http://localhost:3000/rails/mailers/event_mailer/new_event_notification
  def new_event_notification
    EventMailer.new_event_notification
  end
end
