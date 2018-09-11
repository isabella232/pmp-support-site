require 'rails_helper'

describe 'registration routing', type: :routing do
  it "routes GET '/register' to 'register#new'" do
    expect(get('/register')).to route_to('register#new')
  end

  it "routes POST '/register' to 'register#create'" do
    expect(post('/register')).to route_to('register#create')
  end
end
