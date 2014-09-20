require 'rails_helper'

feature 'pmp proxy' do
  include AuthHelper

  def json
    JSON.parse(page.source)
  rescue JSON::ParserError
    {}
  end

  scenario 'displays account info', public_proxy: true do
    visit public_proxy_path
    expect(page.status_code).to eq(200)
    expect(json['href']).to include('api.pmp.io')
    expect(json['attributes']['title']).to eq('PMP Home Document')
  end

  scenario 'requires login for user info' do
    visit user_proxy_path
    expect(page.status_code).to eq(401)
  end

  scenario 'proxies with user credentials' do
    do_login!
    visit user_proxy_path
    expect(page.status_code).to eq(200)
    expect(json['href']).to include(pmp_host)
    expect(json['attributes']['title']).to eq('PMP Home Document')
  end

  scenario 'passes on query parameters' do
    visit public_proxy_path('docs', limit: 1)
    expect(page.status_code).to eq(200)
    expect(json['href']).to include('api.pmp.io')
    expect(json['href']).to include('limit=1')
    expect(json['items'].count).to eq(1)
  end

end
