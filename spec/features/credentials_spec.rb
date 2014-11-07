require 'rails_helper'

feature 'client credentials' do
  include AuthHelper

  before(:each) { do_login! }

  scenario 'ensures a support-app client on login' do
    visit credentials_path
    expect(page).to have_content('pmp-support-app')
    row = page.find('tr', text: 'pmp-support-app')
    client_id = row.find('.client-id').text

    visit logout_path(revoke: true)
    expect(page).to have_content('You have been logged out')

    do_login!
    visit credentials_path
    expect(page).to have_content('pmp-support-app')
    row = page.find('tr', text: 'pmp-support-app')
    new_client_id = row.find('.client-id').text

    expect(new_client_id).not_to eq(client_id)
  end

  scenario 'cancels adding a credential', js: true do
    visit credentials_path
    start_count = page.all('#main table tr').count

    click_button 'New Client'
    expect(page).to have_content('Save')
    expect(page).to have_content('Cancel')
    click_button 'Cancel'

    expect(page).not_to have_content('Save')
    expect(page).not_to have_content('Cancel')
    expect(page.all('#main table tr').count).to eq(start_count)
  end

  scenario 'adds and removes credentials', js: true do
    visit credentials_path
    start_count = page.all('#main table tr').count

    click_button 'New Client'
    fill_in 'your-label-here', with: 'support-app-credentials-spec'
    find(".new-scope").select('read')
    find(".new-expires").select('1 hour')
    click_button 'Save'

    expect(page).to have_content('Created client')
    added_row = page.all('tr', text: 'support-app-credentials-spec').last
    expect(added_row).to have_content('support-app-credentials-spec')
    expect(added_row).to have_content('read')
    expect(added_row).to have_content('1 hour')
    expect(page.all('#main table tr').count).to eq(start_count + 1)

    while row = page.all('tr', text: 'support-app-credentials-spec').first
      row.find('button').trigger('click')
      expect(page).to have_content('Really delete client?')
      page.find('.modal').click_button('Delete')
      expect(page).to have_content('Deleted client')
    end

    expect(page).not_to have_content('support-app-credentials-spec')
  end

end
