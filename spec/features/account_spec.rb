require 'rails_helper'

feature 'user account' do
  include AuthHelper

  before(:each) do
    do_login!
    visit account_path
  end

  scenario 'displays account info' do
    expect(page).to have_content(pmp_username)
    expect(page).to have_content(pmp_host)
  end

  scenario 'update requires username' do
    fill_in 'Username', with: ''
    click_button 'Update'
    expect(page).to have_content('Username is required')
  end

  scenario 'update checks username length' do
    fill_in 'Username', with: 'me'
    click_button 'Update'
    expect(page).to have_content('Username is too short')
  end

  scenario 'update remotely validates username' do
    fill_in 'Username', with: 'pmp'
    click_button 'Update'
    expect(page).to have_content('Username is already taken')
  end

  scenario 'update validates password strength' do
    fill_in 'Password', with: 'password'
    click_button 'Update'
    expect(page).to have_content('That password is weak')
  end

  scenario 'update requires email' do
    fill_in 'Email', with: ''
    click_button 'Update'
    expect(page).to have_content('Email is required')
  end

  scenario 'update validates email' do
    fill_in 'Email', with: 'foo@bar'
    click_button 'Update'
    expect(page).to have_content('Invalid email address')
  end

  scenario 'update requires title' do
    fill_in 'Title', with: ''
    click_button 'Update'
    expect(page).to have_content('Title is required')
  end

  scenario 'update checks title length' do
    fill_in 'Title', with: 'foo'
    click_button 'Update'
    expect(page).to have_content('Title is too short')
  end

  scenario 'can make updates' do
    old_title = find_field('Title').value
    new_title = "#{old_title.gsub(/\s*\d+$/, '')} #{Time.now.to_i}"

    fill_in 'Username', with: pmp_username
    fill_in 'Password', with: pmp_password
    fill_in 'Email', with: find_field('Email').value
    fill_in 'Title', with: new_title
    click_button 'Update'
    expect(page).to have_content('Your account has been updated')
    expect(find_field('Title').value).to eq(new_title)
  end

end
