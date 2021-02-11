# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventMailer, type: :mailer do
  describe '#new_event_notification' do
    let(:event) { create(:event) }

    it 'generates notification email' do
      mailer = described_class.with(event: event).new_event_notification

      expect(mailer.subject).to eq("New event #{event.title}")
    end
  end
end
