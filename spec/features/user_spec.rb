# frozen_string_literal: true

require 'rails_helper'

def fill_sign_up_form(user)
  fill_in 'user[email]', with: user[:email]
  fill_in 'user[password]', with: user[:password]
  fill_in 'user[password_confirmation]', with: user[:password]
  fill_in 'user[name]', with: user[:name]
  fill_in 'user[last_name]', with: user[:last_name]
end

def fill_log_in_form(email, password)
  fill_in 'user[email]', with: email
  fill_in 'user[password]', with: password
end

RSpec.describe User, type: feature do
  let(:user) { FactoryBot.create(:user) }
  let(:attributes) { FactoryBot.attributes_for(:user) }

  describe 'Sign up' do
    before 'go to sign up page' do
      visit '/'
      click_link 'Sign up'
    end

    it 'shows sign up form' do
      expect(page).to have_current_path '/users/sign_up'
    end

    it 'fills sign up form' do
      fill_sign_up_form(attributes)
      click_button 'Sign up'

      expect(page).to have_content 'Welcome! You have signed up successfully.'
    end
  end

  describe 'Sign in' do
    before 'go to sign in page' do
      visit '/'
      click_link 'Sign in'
    end

    it 'shows sign in form' do
      expect(page).to have_current_path '/users/sign_in'
    end

    it 'fills sign in form' do
      fill_log_in_form(user.email, user.password)
      click_button 'Log in'

      expect(page).to have_content 'Signed in successfully.'
    end
  end
end
