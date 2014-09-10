require 'rails_helper'

feature 'api documentation' do

  let(:markdown_titles) do
    Dir.glob("#{Rails.root}/docs/*.md").map do |file|
      File.open(file, &:gets).gsub(/^#/, '').strip
    end
  end

  scenario 'user goes to the docs page' do
    visit docs_path
    expect(page.all('h1').count).to eq(markdown_titles.count)
    markdown_titles.each do |hdr|
      expect(page).to have_content(hdr)
    end
  end

end
