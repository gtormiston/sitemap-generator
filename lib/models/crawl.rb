# understands the content of a web page
require "httparty"
require "uri"
require "nokogiri"
require "addressable/uri"
require_relative "../helpers/http_helpers"

class Crawl

  attr_reader :url, :processed, :site_info

  def initialize(url)
    @url = prepend_http(url)
    @processed = [["/",false,false,[]]] # [link,link_crawl_complete,asset_crawl_complete,'list of assets for link'
    @site_info = { links_found: 1, links_crawled: 0, external_links_found: 0 }
  end

  def crawl
    url = Addressable::URI.parse(@url)
    loop_through_links(url)
    # check status of each link to ensure they are available?
    # store the response.body along with the link in a hash like link:body
    # iterate through the hash to find all the static assets in the
  end

  def loop_through_links(url)
    while @site_info[:links_found] > @site_info[:links_crawled] do
      #  loops through available, uncrawled urls in the @processed array
      #  something like if @processed.any? x[0] == (link) && [1] == false
        body = get_body(url)
        process_links(body)
      #  then check if assets == true
      # process_assets(body)
      # else move on i++
    end
  end

  def process_links(body)
    # access array for the url
    document = parse_html(body)
    i = 0
    count = document.css('a').count
    while i < count do
      link = document.css('a')[i]['href']
      if internal?(link)
        check_link_and_save(link)
        @site_info[:links_found] += 1
      end
      i+=1
    end
    # update array [1] to true
  end

  def process_assets(document)
    # goes through the HTML and finds the image tags on the site
    # replace this with all assets
    i = 0
    num = doc.xpath("//img").count
    while i < num  do
       puts doc.xpath("//img")[i]['src']
       # check asset is local before saving?
       i +=1
    end
    # update array [2] to true
  end

  private

  def get_body(url)
    response = HTTParty.get(url)
    response.body
  end

  def parse_html(html)
    Nokogiri::HTML(html)
  end

  def internal?(link)
    prefix = %w( http https // )
    if !prefix.include?(URI.parse(link).scheme)
      true
    else
      link = Addressable::URI.parse(link).host.downcase
      url = Addressable::URI.parse(@url).host.downcase
      if link == url
        true
      else
        @site_info[:external_links_found] += 1
        return false
      end
    end
  end

  def check_link_and_save(link)
    uri = Addressable::URI.parse(link)
    link = uri.path
    @processed << [link,false,false,[]] unless @processed.any? {|x| x[0] == (link)}
  end

end
