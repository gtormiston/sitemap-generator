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
    p url
    loop_through_links(url)
    # print page or send to page
  end

  def loop_through_links(url)
    while @site_info[:links_found] > @site_info[:links_crawled] do
      #  loops through available, uncrawled urls in the @processed array
      #  something like if @processed.any? x[0] == (link) && [1] == false
      @processed.each do |link_array|
        if link_array[1] == false
          p "crawling: " + link_array[0]
          body = get_body(url)
          process_links(body)
          link_array[1] = true
          @site_info[:links_crawled] += 1
        # elsif link_array[2] == false
        #   process_assets(body)
        #   link_array[2] = true
        end
      end

      p @site_info[:links_found]
      p @site_info[:links_crawled]
      #  then check if assets == true
      # process_assets(body)
      # else move on i++
    end
    p "complete"
  end

  def process_links(body)
    document = parse_html(body)
    i = 0
    count = document.css('a').count
    while i < count do
      link = document.css('a')[i]['href']
      if !link.nil?
        if internal?(link)
          check_link_and_save(link)
        end
      end
      i+=1
    end
    # update array [1] to true
  end

  def clean_link(link)
    link = link.split('?')[0]
    link = link.split('#')[0]
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
    if !prefix.include?(URI.parse(link).scheme) && !link.start_with?("//")
      true
    else
      link = Addressable::URI.parse(link).host.downcase
      url = Addressable::URI.parse(@url).host.downcase
      if link == url
        true
      else
        @site_info[:external_links_found] += 1
        p "eternal link: " + link
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
        @site_info[:links_found] += 1
      end
    end
    p @processed
    p @site_info
  end

end
