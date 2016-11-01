require 'spec_helper'

feature "Sitemap Generator" do

  scenario "Loads index page with form" do
    visit('/')
    expect(page).to have_content('Sitemap Generator')
    page.find(:css,'.url-form')
  end

end
