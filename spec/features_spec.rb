require 'spec_helper'

feature "Features" do

  scenario "Loads index page with form" do
    visit('/')
    expect(page).to have_content('Sitemap Generator')
    page.find(:css,'.url-form')
  end

  scenario "Form captures URL without prefix" do
    visit('/')
    fill_in('url', :with => 'ormi.io')
    find('#verify').click
    expect(page).to have_content('Results for domain: ormi.io')
  end

  scenario "Form captures URL with prefix" do
    visit('/')
    fill_in('url', :with => 'http://ormi.io')
    find('#verify').click
    expect(page).to have_content('Results for domain: ormi.io')
  end

  scenario "Returns to the form page with an error if the url ping fails" do
    visit('/')
    fill_in('url', :with => 'foo.bar')
    find('#verify').click
    expect(page).to have_content('Are you sure foo.bar is a domain?')
  end


end
