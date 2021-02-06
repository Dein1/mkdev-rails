# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::EventsController, type: :controller do
  before do
    sign_in create(:admin)
  end

  describe 'GET index' do
    it 'assigns @events' do
      event = create(:event)
      get :index
      expect(assigns(:events)).to eq [event]
    end
  end

  describe 'GET /edit' do
    it 'assign @event' do
      event = create(:event)
      get :edit, params: { id: event.id }
      expect(assigns(:event)).to eq event
    end
  end

  describe 'PUT /update' do
    it 'changes event title' do
      event = create(:event)
      put :update, params: { id: event.id, event: { title: 'new title' } }
      expect(assigns(:event).title).to eq 'new title'
    end
  end

  describe 'delete /admin' do
    it 'deletes event as admin' do
      event = create(:event)
      delete :destroy, params: { id: event.id }
      expect(Event.find_by(id: event.id)).to be_nil
    end
  end
end
