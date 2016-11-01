require 'spec_helper'

feature "Sitemap Generator" do

  scenario "Loads index page" do
    visit('/')
    expect(page).to have_content('Sitemap Generator')
  end

end
