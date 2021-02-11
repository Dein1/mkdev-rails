# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'notifications@events.com'

  layout 'mailer'
end
