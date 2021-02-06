# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Admin::Events', type: :request do
  let(:admin) { create(:admin) }
  let(:user) { create(:user) }
  let!(:event) { create(:event, author: user) }

  describe 'GET /admin/' do
    context 'with admin signed in' do
      before do
        sign_in admin
        get admin_events_path
      end

      it { expect(response).to have_http_status :success }
      it { is_expected.to render_template :index }
    end

    context 'with user signed in' do
      before do
        sign_in user
        get admin_events_path
      end

      it { expect(response).to have_http_status :found }

      it 'redirects' do
        response.should redirect_to(admin_session_path)
        follow_redirect!
        expect(response).to have_http_status :success
      end
    end
  end

  describe 'GET /edit' do
    before do
      sign_in admin
      get edit_admin_event_path(event)
    end

    it { is_expected.to render_template :edit }
  end

  describe 'PUT /update' do
    subject(:update_request) { put admin_event_url(event), params: params }

    before { sign_in admin }

    let(:params) { { event: { title: 'new title!' } } }

    it 'updates' do
      update_request
      expect(event.reload.title).to eql 'new title!'
    end

    it { is_expected.to redirect_to admin_events_path }
  end

  describe 'DELETE /' do
    subject(:delete_request) { delete admin_event_url(event) }

    before { sign_in admin }

    it { expect { delete_request }.to change(Event, :count).by(-1) }
    it { is_expected.to redirect_to admin_events_path }
  end
end
