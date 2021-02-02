# frozen_string_literal: true

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
