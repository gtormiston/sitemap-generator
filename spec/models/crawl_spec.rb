require 'spec_helper'

describe Crawl do

  subject{ Crawl.new("ormi.io") }
  let(:domain) { "ormi.io" }

  context 'scraping content' do
    it 'stores page and content in a hash' do
      expect(subject.site).to be_kind_of(Hash)
    end
  end

  context 'following page links' do
    it 'checks the links that match the given domain' do

    end
    it 'does not follow external links'
    it 'stores links in an array' do
      expect(subject.pages).to be_kind_of(Array)
      expect(subject.pages.count).to be(0)
    end
    it 'deletes duplicate links'
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
