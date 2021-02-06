# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EventsController, type: :controller do
  before do
    sign_in create(:user)
  end

  let!(:approved_event) { create(:event) }
  let(:pending_event) { create(:pending_event) }

  describe 'GET index' do
    it 'assign only approved event to @events' do
      get :index
      expect(assigns(:events)).to eq [approved_event]
    end
  end
end
