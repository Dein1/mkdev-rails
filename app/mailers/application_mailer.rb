# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: Settings.notify_email

  layout 'mailer'
end
