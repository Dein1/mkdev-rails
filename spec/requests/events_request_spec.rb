# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :request do
  before do
    DatabaseCleaner.clean
    sign_in user
  end

  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:user) }

  describe 'GET /' do
    before { get events_path }

    it { expect(response).to have_http_status :success }
    it { is_expected.to render_template :index }
  end

  describe 'GET /new' do
    before { get new_event_path }

    it { is_expected.to render_template :new }
  end

  describe 'POST /' do
    subject(:request) { post events_path, params: params }

    let(:params) { { event: FactoryBot.attributes_for(:event) } }

    it { expect { request }.to change(Event, :count).by(1) }
  end

  describe 'GET /edit' do
    let(:event) { FactoryBot.create(:event, author: user) }

    before { get edit_event_path(event) }

    it { is_expected.to render_template :edit }
  end

  describe 'PUT /update' do
    subject(:update) { put event_url(event), params: params }

    let(:event) { FactoryBot.create(:event, author: user) }

    context 'when successed' do
      let(:params) { { event: { title: 'new title!' } } }

      it 'redirects' do
        expect(update).to redirect_to events_path
      end
    end

    context 'when failed' do
      subject(:update) { put event_url(event), params: invalid_params }

      let(:invalid_params) { { event: { title: '' } } }

      it 'does not redirect with invalid params' do
        expect(update).not_to redirect_to events_path
      end
    end
  end

  describe 'DELETE /' do
    subject(:request) { delete event_url(event) }

    let!(:event) { FactoryBot.create(:event, author: user) }

    it { expect { request }.to change(Event, :count).by(-1) }
  end
end
