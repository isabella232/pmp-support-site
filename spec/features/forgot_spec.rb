require 'rails_helper'

feature 'forgot password' do
  include AuthHelper

  let(:mails)      { ActionMailer::Base.deliveries }
  let(:first_mail) { ActionMailer::Base.deliveries.first }
  before(:each)    { ActionMailer::Base.deliveries.clear }

  let(:fake_user) do
    double('User Doc', emails: [], email: nil)
  end

  let(:password_reset) do
    PasswordReset.create(email_address: 'foo@bar.com', user_name: pmp_username, user_guid: '12345678', host: pmp_host)
  end

  scenario 'fails to fill out all fields' do
    visit forgot_path
    click_button 'Email reset instructions'
    expect(page).to have_content('Please fill out all fields')
  end

  scenario 'sets a fancy reverse captcha field' do
    visit forgot_path
    set_host_picker pmp_host
    fill_in 'Username', with: 'foobar'
    page.find('#username').set('foobar')
    click_button 'Email reset instructions'
    expect(page).to have_content('Hidden form fields were submitted')
  end

  scenario 'username not found' do
    visit forgot_path
    set_host_picker pmp_host
    fill_in 'Username', with: 'foobar93052758'
    click_button 'Email reset instructions'
    expect(page).to have_content('Unable to find a user by that name')
  end

  scenario 'too many users with that name' do
    allow_any_instance_of(PasswordResetController).to receive(:user_items) { [fake_user, fake_user] }
    visit forgot_path
    set_host_picker pmp_host
    fill_in 'Username', with: pmp_username
    click_button 'Email reset instructions'
    expect(page).to have_content('too many users with that name')
  end

  scenario 'user has no email' do
    allow_any_instance_of(PasswordResetController).to receive(:user_items) { [fake_user] }
    visit forgot_path
    set_host_picker pmp_host
    fill_in 'Username', with: pmp_username
    click_button 'Email reset instructions'
    expect(page).to have_content('No email associated with user')
  end

  scenario 'invalid reset link' do
    expect { visit reset_password_path('foobar') }.to raise_error(ActiveRecord::RecordNotFound)
  end

  scenario 'expired reset link' do
    password_reset.update_attribute(:created_at, 15.days.ago)
    visit reset_password_path(password_reset.token)
    expect(page).to have_content('that link has expired')
    expect(PasswordReset.count).to eq(0)
  end

  scenario 'reset requires all fields' do
    visit reset_password_path(password_reset.token)
    click_button 'Change password'
    expect(page).to have_content('Please fill out all fields')
    expect(PasswordReset.count).to eq(1)
  end

  scenario 'reset checks username' do
    visit reset_password_path(password_reset.token)
    fill_in 'Username', with: 'foobar'
    fill_in 'New password', with: pmp_password
    fill_in 'Confirm new password', with: pmp_password
    click_button 'Change password'
    expect(page).to have_content('Incorrect username provided')
    expect(PasswordReset.count).to eq(1)
  end

  scenario 'reset matches passwords' do
    visit reset_password_path(password_reset.token)
    fill_in 'Username', with: pmp_username
    fill_in 'New password', with: pmp_password
    fill_in 'Confirm new password', with: 'foobarfoobar12345'
    click_button 'Change password'
    expect(page).to have_content('Password does not match confirmation')
    expect(PasswordReset.count).to eq(1)
  end

  scenario 'reset checks password strength' do
    visit reset_password_path(password_reset.token)
    fill_in 'Username', with: pmp_username
    fill_in 'New password', with: '4'
    fill_in 'Confirm new password', with: '4'
    click_button 'Change password'
    expect(page).to have_content('Your password is weak')
    expect(PasswordReset.count).to eq(1)
  end

  scenario 'full reset path works' do
    visit forgot_path
    set_host_picker pmp_host
    fill_in 'Username', with: pmp_username
    click_button 'Email reset instructions'
    expect(page).to have_content('An email with reset instructions has been sent')

    expect(PasswordReset.count).to eq(1)
    expect(PasswordReset.first.user_name).to eq(pmp_username)

    expect(mails.count).to eq(1)
    expect(first_mail.from).to include('support@publicmediaplatform.org')
    expect(first_mail.subject).to eq("Reset your #{pmp_host} password")
    expect(first_mail.body).to include(PasswordReset.first.token)

    visit reset_password_path(PasswordReset.first.token)
    fill_in 'Username', with: pmp_username
    fill_in 'New password', with: pmp_password
    fill_in 'Confirm new password', with: pmp_password
    click_button 'Change password'
    expect(page).to have_content('Password changed!')
    expect(current_path).to eq(login_path)
    expect(PasswordReset.count).to eq(0)
  end

end
