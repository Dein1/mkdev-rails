# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  before do
    sign_in create(:admin)
  end

  let!(:event) { create(:event) }
  let(:pending_event) { create(:pending_event) }

  describe 'GET index' do
    it 'assigns @events' do
      get :index
      expect(assigns(:events)).to eq [event]
    end
  end

  describe 'GET /edit' do
    it 'assign @event' do
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq event
    end
  end

  describe 'PUT /update' do
    context 'with valid params' do
      it 'changes event title' do
        old_title = event.title
        expect do
          put :update, params: { id: event.id, event: { title: 'new title' } }
        end.to change { event.reload.title }.from(old_title).to('new title')
      end
    end

    context 'with invalid params' do
      it 'changes event title' do
        expect do
          put :update, params: { id: event.id, event: { title: '' } }
        end.not_to change { event.reload.title }
      end
    end
  end

  describe 'DELETE /admin' do
    it 'deletes event as admin' do
      delete :destroy, params: { id: event.id }
      expect(Event.find_by(id: event.id)).to be_nil
    end
  end

  describe 'PUT /event/approve' do
    it 'approves' do
      expect do
        put :approve, params: { event_id: pending_event.id }
      end.to change { pending_event.reload.state }.from('pending').to('approved')
    end
  end

  describe 'PUT /event/reject' do
    it 'rejects' do
      expect do
        put :reject, params: { event_id: pending_event.id }
      end.to change { pending_event.reload.state }.from('pending').to('rejected')
    end
  end

  describe 'GET pending' do
    it 'assigns events' do
      get :pending
      expect(assigns(:events)).to eq [pending_event]
    end
  end
end
