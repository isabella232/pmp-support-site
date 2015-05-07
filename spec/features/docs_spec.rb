require 'rails_helper'

feature 'api documentation' do

  # get the first h1 header from a markdown file
  def title_from_file(file)
    txt = IO.read(file)
    hdr = txt[/^#[^#].+$/]
    if hdr && (!txt.index('```') || txt.index(hdr) < txt.index('```'))
      hdr.gsub(/^#/, '').strip
    else
      nil # header must be before code blocks
    end
  end

  let(:user_titles) do
    Dir.glob("#{Rails.root}/docs/users/*.md").map(&method(:title_from_file)).compact
  end

  let(:developer_titles) do
    Dir.glob("#{Rails.root}/docs/developers/*.md").map(&method(:title_from_file)).compact
  end

  scenario 'user goes to the user guides page' do
    visit guides_path
    expect(page.all('h1').count).to eq(user_titles.count)
    user_titles.each do |hdr|
      expect(page).to have_content(hdr)
    end
  end

  scenario 'user goes to the developer docs page' do
    visit docs_path
    expect(page.all('h1').count).to eq(developer_titles.count)
    developer_titles.each do |hdr|
      expect(page).to have_content(hdr)
    end
  end

end
