require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe "GET /" do
    before { get "/events" }

    it { expect(response).to have_http_status :success }
    it { should render_template :index }
  end

  describe "GET /new" do
    before { get "/events/new" }

    it { should render_template :new }
  end

  describe "POST /create" do
    let(:params) { { event: FactoryBot.attributes_for(:event) } }
    before { post "/events", params: params }

    it { should redirect_to events_path }
  end
end
