# frozen_string_literal: true

require 'dry/monads'
require 'dry/monads/do'

class EventCreator < ApplicationService
  include Dry::Monads[:result, :do]
  include Dry::Monads::Do.for(:call)

  def call(params, user)
    event = yield create_event(params, user)
    send_email(event)

    Success(event)
  end

  private

  def create_event(params, user)
    event = user.events.create(params)
    Success(event)
  end

  def send_email(event)
    EventMailer.with(event: event).new_event_notification.deliver_later
  end
end
