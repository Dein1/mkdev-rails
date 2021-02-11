# frozen_string_literal: true

class EventMailer < ApplicationMailer
  def new_event_notification
    emails = Admin.all.map(&:email)
    mail(to: emails, subject: "New event #{params[:event].title}")
  end
end
