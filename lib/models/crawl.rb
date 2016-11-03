# understands the content of a web page
require "httparty"
require 'net/http'
require "uri"
require "nokogiri"
require "addressable/uri"
require 'sanitize'
require_relative "../helpers/http_helpers"

class Crawl

  attr_reader :url, :processed, :site_info

  def initialize(url)
    @url = prepend_http(url)
    @processed = [["/",false,false,[]]] # [link,link_crawl_complete,asset_crawl_complete,'list of assets for link'
    @external_links = []
    @site_info = { links_found: 1, links_crawled: 0, external_links_found: 0 }
  end

  def crawl
    url = Addressable::URI.parse(@url)
    loop_through_links(url)
    # print page or send to page
  end

  def loop_through_links(url)
    while @site_info[:links_found] > @site_info[:links_crawled] do
      @processed.each do |link_array|
        if link_array[1] == false
          p "crawling: " + link_array[0]
          body = get_body(url)
          process_links(body)
          link_array[1] = true
          increment_crawled
          assets = process_assets(body)
          link_array[3] = assets
          link_array[2] = true
        end
      end
    end
    puts "***complete***"
  end

  def process_links(body)
    doc = parse_html(body)
    i = 0
    count = doc.css('a').count
    while i < count do
      link = doc.css('a')[i]['href']
      if !link.nil?
        if internal?(link)
          check_link_and_save(link)
        end
      end
      i+=1
    end
  end

  def process_assets(body)
    doc = parse_html(body)
    assets = []
    doc.xpath('//script/@src').each do |link|
      unless link.value.nil?
        assets << clean_link(link.value)
      end
    end
    doc.xpath('//img/@src').each do |link|
      assets << clean_link(link.value)
    end
    doc.xpath('//link[@rel="stylesheet"]/@href').each do |link|
      assets << clean_link(link.value)
    end
    return assets
  end

  private

  def get_body(url)
    response = HTTParty.get(URI.parse(url))
    response.body
  end

  def parse_html(html)
    Nokogiri::HTML(html)
  end

  def clean_link(link)
    link = link.split('?')[0]
    link = link.split('#')[0]
  end

  def internal?(link)
    prefix = %w( http https // )
    if !prefix.include?(URI.parse(link).scheme) && !link.start_with?("//")
      true
    else
      link = Addressable::URI.parse(link).host.downcase
      url = Addressable::URI.parse(@url).host.downcase
      if link == url
        true
      else
        @external_links << link
        increment_external_found
        return false
      end
    end
  end

  def check_link_and_save(link)
    link = clean_link(link)
    if link =~ URI::regexp
      uri = Addressable::URI.parse(link)
      link = uri.path
    end
    unless link == nil || link == ''
      unless @processed.any? {|x| x[0] == (link)}
        @processed << [link,false,false,[]]
        increment_found
      end
    end
  end

  def increment_crawled
    @site_info[:links_crawled] += 1
  end

  def increment_found
    @site_info[:links_found] += 1
  end

  def increment_external_found
    @site_info[:external_links_found] += 1
  end

end
