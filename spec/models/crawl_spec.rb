require 'spec_helper'
require 'helpers/crawl_helpers'

p html_single_link

describe Crawl do

  subject{ Crawl.new("ormi.io") }
  let(:domain) { "ormi.io" }

  context 'scraping content' do
    it 'stores page and content in a hash' do
      expect(subject.site).to be_kind_of(Hash)
    end
  end

  context 'following page links' do
    it 'stores internal links in an array' do
      expect(subject.links).to be_kind_of(Array)
      expect(subject.links.count).to be(0)
      expect{subject.get_links(html_single_link)}.to change{subject.links.count}.by(1)
    end
    it 'does not store external links' do
      expect{subject.get_links(html_external_link)}.to change{subject.links.count}.by(0)
    end
    it 'deletes duplicate links' do
      expect{subject.get_links(html_single_link)}.to change{subject.links.count}.by(1)
      expect{subject.get_links(html_single_link)}.to change{subject.links.count}.by(0)
    end
  end

  context 'static assets' do
    it 'does not record external static assets'
    it 'stores assets in an empty array' do
      expect(subject.assets).to be_kind_of(Array)
      expect(subject.assets.count).to be(0)
    end
  end

  context 'warnings' do
    it 'checks canonical against the given domain'
    it 'warns if http content is being served from https site'
  end

end
