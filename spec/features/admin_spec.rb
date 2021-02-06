# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin, type: :feature do
  let(:admin) { create(:admin) }
  let(:attributes) { attributes_for(:admin) }

  describe 'Sign in' do
    before 'go to sign in page' do
      visit '/admin'
    end

    it 'fills sign in form' do
      fill_admin_form(admin.email, admin.password)
      click_button 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end

    it 'fills sign in form with invalid data' do
      fill_admin_form(Faker::Lorem.word, Faker::Lorem.word)
      click_button 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end
