include ApplicationHelper

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

def sign_in(user, options={})
  if options[:no_capybara]
    remember_token = User.new_remember_token
    cookies[:remember_token] = remember_token
    user.update_attribute(:remember_token, User.encrypt(remember_token))
  else
    visit signin_path
    valid_signin(user)
  end
end

def valid_signin(user)
  fill_in "Email",    with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def valid_edit(user, new_name, new_email)
  fill_in 'Name', with: new_name
  fill_in 'Email', with: new_email
  fill_in 'Password', with: user.password
  fill_in 'Confirm Password', with: user.password
  click_button 'Save changes'
end

def valid_signup
  fill_in 'Name', with: 'Example User'
  fill_in 'Email', with: 'user@example.com'
  fill_in 'Password', with: 'foobar'
  fill_in 'Confirmation', with: 'foobar'
end

