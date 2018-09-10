require 'rails_helper'

describe 'dashboard routing', type: :routing do
  it "routes GET '/stats' to 'dashboard#stats'" do
    expect(get('/stats')).to route_to('dashboard#stats')
  end

  it "routes root_path to 'dashboard#index'" do
    expect(get: root_path).to route_to('dashboard#index')
  end
end
