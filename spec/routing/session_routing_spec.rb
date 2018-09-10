require 'rails_helper'

describe 'session routing', type: :routing do
  it "routes GET '/login' to 'sessions#login'" do
    expect(get('/login')).to route_to('sessions#login')
  end

  it "routes GET '/add_account' to 'sessions#add_account'" do
    expect(get('/add_account')).to route_to('sessions#add_account')
  end

  it "routes GET '/switch/:key' to 'sessions#switch'" do
    expect(get('/switch/:key')).to route_to(controller: 'sessions', action: 'switch', key: ':key')
  end

  it "routes GET '/logout' to 'sessions#logout'" do
    expect(get('/logout')).to route_to('sessions#logout')
  end

  it "routes POST '/login' to 'sessions#login'" do
    expect(post('/login')).to route_to('sessions#do_login')
  end

  it "routes POST '/add_account' to 'sessions#add_account'" do
    expect(post('/add_account')).to route_to('sessions#do_add_account')
  end
end
