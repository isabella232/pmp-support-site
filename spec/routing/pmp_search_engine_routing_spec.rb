require 'rails_helper'

describe 'pmp search engine routing', type: :routing do
  it "routes GET '/search' to 'search#prod_search'" do
    expect(get('/search')).to route_to('search#prod_search')
  end

  it "routes GET '/sandboxsearch' to 'search#sandbox_search'" do
    expect(get('/sandboxsearch')).to route_to('search#sandbox_search')
  end
end
