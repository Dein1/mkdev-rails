require 'rails_helper'

RSpec.describe "Events", type: :request do

  describe "GET /" do
    before { get "/events" }

    it { expect(response).to have_http_status(:success) }
    it { should render_template("index") }
  end
end
