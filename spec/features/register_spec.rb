require 'rails_helper'

feature 'user registration' do
  include AuthHelper

  let(:mails)      { ActionMailer::Base.deliveries }
  let(:first_mail) { ActionMailer::Base.deliveries.first }
  before(:each)    { ActionMailer::Base.deliveries.clear }

  scenario 'fails to fill out all fields' do
    visit register_path
    click_button 'Send request'
    expect(page).to have_content('Please fill out all fields')
  end

  scenario 'sets a fancy reverse captcha field' do
    visit register_path
    set_host_picker 'https://api.pmp.io'
    fill_in 'Your name', with: 'Foo Bar'
    fill_in 'Contact email', with: 'foo@bar.com'
    fill_in 'Name of organization', with: 'Foobar Inc'
    fill_in 'Username requested', with: 'foobar'
    fill_in 'For what purpose do you intend to use the PMP?', with: 'Profit'
    page.find('#username').set('foobar')
    click_button 'Send request'
    expect(page).to have_content('Hidden form fields were submitted')
  end

  scenario 'successful registration' do
    visit register_path
    set_host_picker 'https://api.pmp.io'
    fill_in 'Your name', with: 'Foo Bar'
    fill_in 'Contact email', with: 'foo@bar.com'
    fill_in 'Name of organization', with: 'Foobar Inc'
    fill_in 'Username requested', with: 'foobar'
    fill_in 'For what purpose do you intend to use the PMP?', with: 'Profit'
    click_button 'Send request'
    expect(page).to have_content('your request has been sent')
    expect(current_path).to eq(login_path)

    expect(mails.count).to eq(1)
    expect(first_mail.to).to include('support@publicmediaplatform.org')
    expect(first_mail.subject).to eq('PMP registration request from Foo Bar')
  end

end
