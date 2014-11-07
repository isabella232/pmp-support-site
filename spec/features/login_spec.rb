require 'rails_helper'

feature 'user login' do
  include AuthHelper

  scenario 'fails to fill out all fields' do
    visit login_path
    click_button 'Sign in'
    expect(page).to have_content('Please fill out all fields')
  end

  scenario 'invalid username' do
    visit login_path
    set_host_picker pmp_host
    fill_in 'Username', with: 'Foobar'
    fill_in 'Password', with: pmp_password
    click_button 'Sign in'
    expect(page).to have_content('Invalid username/password')
  end

  scenario 'invalid password' do
    visit login_path
    set_host_picker pmp_host
    fill_in 'Username', with: pmp_username
    fill_in 'Password', with: 'Foobar'
    click_button 'Sign in'
    expect(page).to have_content('Invalid username/password')
  end

  scenario 'does not use a fancy reverse captcha field' do
    visit login_path
    fill_in 'Username', with: 'Foobar'
    page.find('#password').set(pmp_password)
    click_button 'Sign in'
    expect(page).not_to have_content('Please fill out all fields')
    expect(page).to have_content('Invalid username/password')
  end

  scenario 'successful login' do
    do_login!
    expect(current_path).to eq(credentials_path)
  end

end
