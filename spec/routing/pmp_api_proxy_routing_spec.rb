require 'rails_helper'

describe 'pmp api proxy routing', type: :routing do
  it "routes GET '/proxy/sandbox' to 'proxy#public_proxy'" do
    expect(get('/proxy/sandbox')).to route_to(controller: 'proxy', action: 'public_proxy', proxy_env: 'sandbox')
  end

  it "routes GET '/proxy/public' to 'proxy#public_proxy'" do
    expect(get('/proxy/public')).to route_to(controller: 'proxy', action: 'public_proxy', proxy_env: 'production')
  end

  it "routes GET '/proxy/current' to 'proxy#current_user_proxy'" do
    expect(get('/proxy/current')).to route_to('proxy#current_user_proxy')
  end
end
