require 'rails_helper'

feature 'api documentation' do

  let(:markdown_titles) do
    non_null_titles = []
    Dir.glob("#{Rails.root}/docs/*.md").map do |file|
      txt = IO.read(file)
      hdr = txt[/^#[^#].+$/]

      # must occur before first code block
      if hdr
        if !txt.index('```') || txt.index(hdr) < txt.index('```')
          non_null_titles << hdr.gsub(/^#/, '').strip
        end
      end
    end
    non_null_titles
  end

  scenario 'user goes to the docs page' do
    visit docs_path
    expect(page.all('h1').count).to eq(markdown_titles.count)
    markdown_titles.each do |hdr|
      expect(page).to have_content(hdr)
    end
  end

end
