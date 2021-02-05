# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :request do
  before { sign_in user }

  let(:user) { create(:user) }
  let(:other_user) { create(:user) }

  describe 'GET /' do
    before { get events_path }

    it { expect(response).to have_http_status :success }
    it { is_expected.to render_template :index }
  end

  describe 'GET /event' do
    before { get event_path(event) }

    let(:event) { create(:event, author: user) }

    it { expect(response).to have_http_status :success }
    it { is_expected.to render_template :show }
  end

  describe 'GET /new' do
    before { get new_event_path }

    it { is_expected.to render_template :new }
  end

  describe 'POST /' do
    subject(:create_request) { post events_path, params: params }

    let(:params) { { event: attributes_for(:event) } }

    it { expect { create_request }.to change(Event, :count).by(1) }
    it { is_expected.to redirect_to events_path }
  end

  describe 'GET /edit' do
    let(:event) { create(:event, author: user) }

    before { get edit_event_path(event) }

    it { is_expected.to render_template :edit }
  end

  describe 'PUT /update' do
    subject(:update_request) { put event_url(event), params: params }

    let(:event) { create(:event, author: user) }

    context 'with valid params' do
      let(:params) { { event: { title: 'new title!' } } }

      it 'updates' do
        update_request
        expect(event.reload.title).to eql 'new title!'
      end

      it { is_expected.to redirect_to events_path }
    end

    context 'with invalid params' do
      subject(:update_request) { put event_url(event), params: invalid_params }

      let(:invalid_params) { { event: { title: '' } } }

      it 'does not update' do
        update_request
        expect(event.reload.title).not_to eql 'new title!'
      end

      it { is_expected.not_to redirect_to events_path }
    end

    context 'with different user' do
      subject(:update_request) { put event_url(other_users_event), params: params }

      let(:other_users_event) { create(:event, author: other_user) }
      let(:params) { { event: { title: 'new title!' } } }

      it 'does not update' do
        update_request
        expect(event.reload.title).not_to eql 'new title!'
      end
    end
  end

  describe 'DELETE /' do
    context 'with current user' do
      subject(:delete_request) { delete event_url(event) }

      let!(:event) { create(:event, author: user) }

      it { expect { delete_request }.to change(Event, :count).by(-1) }
      it { is_expected.to redirect_to events_path }
    end

    context 'with different user' do
      subject(:delete_request) { delete event_url(event) }

      let!(:event) { create(:event, author: other_user) }

      it { expect { delete_request }.to change(Event, :count).by(0) }
      it { is_expected.to redirect_to events_path }
    end
  end
end
