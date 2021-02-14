# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventCreator do
  describe '#call' do
    let(:user) { create(:user) }

    context 'with valid params' do
      let(:event_params) { attributes_for(:event) }

      it 'creates event' do
        described_class.call(event_params, user)
        expect(user.events.size).to eq 1
      end

      it 'send email in background' do
        expect do
          described_class.call(event_params, user)
        end.to change {
          ActiveJob::Base.queue_adapter.enqueued_jobs.count
        }.by 1
      end
    end

    context 'with invalid params' do
      let(:event_params) { attributes_for(:event, title: '') }

      it 'does not send email' do
        expect do
          described_class.call(event_params, user)
        end.not_to change {
          ActiveJob::Base.queue_adapter.enqueued_jobs.count
        }
      end
    end
  end
end
