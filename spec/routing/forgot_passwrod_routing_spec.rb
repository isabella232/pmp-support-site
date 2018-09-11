require 'rails_helper'

describe 'forgot password routing', type: :routing do
  it "routes GET '/forgot' to 'password_reset#new'" do
    expect(get('/forgot')).to route_to('password_reset#new')
  end

  it "routes POST '/forgot' to 'password_reset#create'" do
    expect(post('/forgot')).to route_to('password_reset#create')
  end

  it "routes GET '/forgot/:id' to 'password_reset#show'" do
    expect(get('/forgot/:id')).to route_to(controller: 'password_reset', action: 'show', id: ':id')
  end

  it "routes PUT '/forgot/:id' to 'password_reset#update'" do
    expect(put('/forgot/:id')).to route_to(controller: 'password_reset', action: 'update', id: ':id')
  end
end
