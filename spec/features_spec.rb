require 'spec_helper'

feature "Sitemap Generator" do

  scenario "Loads index page with form" do
    visit('/')
    expect(page).to have_content('Sitemap Generator')
    page.find(:css,'.url-form')
  end

  xscenario "Form captures URL" do
      visit('/')
      # fill in input
      # submit
      # expect page to have the entry on it as confirmation
  end

  scenario "Returns to the form if the domain ping fails"


end
