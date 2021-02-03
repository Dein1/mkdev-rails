# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :feature do
  let(:user) { FactoryBot.create(:user) }
  let(:attributes) { FactoryBot.attributes_for(:user) }

  describe 'Sign up' do
    before 'go to sign up page' do
      visit '/'
      click_link 'Sign up'
    end

    it 'fills sign up form with valid data' do
      fill_sign_up_form(attributes)
      click_button 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end

    it 'fills sign up form with invalid data' do
      fill_sign_up_form({ **attributes, email: '' })
      click_button 'Sign up'

      expect(page).to have_content "Email can't be blank"
    end
  end

  describe 'Sign in' do
    before 'go to sign in page' do
      visit '/'
      click_link 'Sign in'
    end

    it 'fills sign in form' do
      fill_log_in_form(user.email, user.password)
      click_button 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end

    it 'fills sign in form with invalid data' do
      fill_log_in_form(Faker::Lorem.word, Faker::Lorem.word)
      click_button 'Log in'

      expect(page).to have_content 'Invalid Email or password.'
    end
  end
end
