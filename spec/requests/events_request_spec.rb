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

  describe "POST /" do
    let(:params) { { event: FactoryBot.attributes_for(:event) } }
    subject { post events_path, params: params }

    it { expect { subject }.to change(Event, :count).by(1) }
  end

  describe "GET /edit" do
    let(:event) { FactoryBot.create(:event) }
    before { get edit_event_path(event) }

    it { should render_template :edit }
  end

  describe "PUT /update" do
    let(:event) { FactoryBot.create(:event) }

    context "success" do
      let(:params) { { event: { title: "new title!" } } }

      it "should redirect" do
        put event_url(event), params: params
        should redirect_to events_path
      end
    end

    context "failure" do
      let(:invalid_params) { { event: { title: "" } } }

      it "shouldn't redirect with invalid params" do
        put event_url(event), params: invalid_params
        should_not redirect_to events_path
      end
    end
  end

  describe "DELETE /" do
    let!(:event) { FactoryBot.create(:event) }
    subject { delete event_url(event) }

    it { expect { subject }.to change(Event, :count).by(-1) }
  end
end
