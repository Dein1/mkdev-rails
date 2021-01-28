require 'rails_helper'

RSpec.describe Event, type: :model do
  
  let(:event) { create(:event) }

  describe "validations" do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }
  end
end
