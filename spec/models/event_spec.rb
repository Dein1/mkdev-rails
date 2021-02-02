# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { create(:event) }

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:author) }
  end
end
