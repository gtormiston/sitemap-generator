require 'spec_helper'
require 'helpers/crawl_helpers'

describe Crawl do

  subject{ Crawl.new("ormi.io") }
  let(:domain) { "ormi.io" }

  context 'scraping content' do
    it 'stores page and content in a hash' do
      expect(subject.site_info).to be_kind_of(Hash)
    end
  end

  context 'following page links' do
    it 'adds root to list of links' do
      expect(subject.processed.count).to be(1)
    end
    it 'stores internal links in an array' do
      expect(subject.processed).to be_kind_of(Array)
      expect(subject.processed.count).to be(1)
      expect{subject.process_links(html_single_link)}.to change{subject.processed.count}.by(1)
    end
    it 'does store internal links when the domain is included in the link' do
      expect(subject.processed.count).to be(1)
      expect{subject.process_links(html_single_internal_domain_link)}.to change{subject.processed.count}.by(1)
    end
    it 'does not store external links' do
      expect{subject.process_links(html_external_link)}.to change{subject.processed.count}.by(0)
    end
    it 'records number of external links found' do
      expect{subject.process_links(html_external_link)}.to change{subject.site_info[:external_links_found]}.by(1)
    end
    it 'does not duplicate links' do
      expect{subject.process_links(html_single_link)}.to change{subject.processed.count}.by(1)
      expect{subject.process_links(html_single_link)}.to change{subject.processed.count}.by(0)
    end
  end

  context 'static assets' do
    it 'stores assets in an empty array' do
      expect(subject.processed).to be_kind_of(Array)
      expect(subject.processed[0][3].count).to be(0)
    end
  end

  # TODO
  context 'warnings for edge cases' do
    it 'checks canonical against the given domain'
    it 'warns if http content is being served from https site'
  end

end
