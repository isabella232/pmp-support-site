require 'rails_helper'

describe 'documentation routing', type: :routing do
  it "routes GET '/guides' to 'docs#users'" do
    expect(get('/guides')).to route_to('docs#users')
  end

  it "routes GET '/docs' to 'docs#developers'" do
    expect(get('/docs')).to route_to('docs#developers')
  end

  it "routes GET '/terms' to 'docs#terms_of_use'" do
    expect(get('/terms')).to route_to('docs#terms_of_use')
  end

  it "routes GET '/service' to 'docs#service_level_agreement'" do
    expect(get('/service')).to route_to('docs#service_level_agreement')
  end
end
