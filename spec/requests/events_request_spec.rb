require 'rails_helper'

RSpec.describe "Events", type: :request do

  before :each do
    DatabaseCleaner.clean
  end

  describe "GET /" do
    before { get events_path }

    it { expect(response).to have_http_status :success }
    it { should render_template :index }
  end

  describe "GET /new" do
    before { get new_event_path }

    it { should render_template :new }
  end

  describe "POST /create" do
    let(:params) { { event: FactoryBot.attributes_for(:event) } }
    before { post events_path, params: params }

    it { should redirect_to events_path }
  end

  describe "GET /edit" do
    let(:event) { FactoryBot.create(:event) }
    before { get edit_event_path(event) }

    it { should render_template :edit }
  end

  describe "DELETE /" do
    let!(:event) { FactoryBot.create(:event) }
    subject { delete event_url(event) }

    it { expect { subject }.to change(Event, :count).by(-1) }
  end
end
