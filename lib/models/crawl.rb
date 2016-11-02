# understands the content of a web page
require "httparty"
require "uri"
require "nokogiri"
require "addressable/uri"
require_relative "../helpers/http_helpers"

class Crawl

  attr_reader :url, :links, :assets, :site

  def initialize(url)
    @url = prepend_http(url)
    @links = []
    @assets = []
    @site = {}
  end

  def crawl
    url = Addressable::URI.parse(@url)
    body = get_body(url)
    # for each page?
    get_links(body)
    # get_assets(body)
    # run through this process for each page in the array, checking the links against the array and not adding duplicates
    # check status of each link to ensure they are available?
    # store the response.body along with the link in a hash like link:body
    # iterate through the hash to find all the static assets in the
  end

  def get_links(body)
    document = Nokogiri::HTML(body)
    i = 0
    count = document.css('a').count
    while i < count do
      link = document.css('a')[i]['href']
      if !link.nil?
        if internal?(link)
          @links.empty? ? @links << link : check_link_and_save(link)
        end
      end
      i +=1
    end
  end

  def get_assets(document)
    # goes through the HTML and finds the image tags on the site
    # replace this with all assets
    i = 0
    num = doc.xpath("//img").count
    while i < num  do
       puts doc.xpath("//img")[i]['src']
       # check asset is local before saving?
       i +=1
    end
  end

  def get_body(url)
    response = HTTParty.get(url)
    response.body
  end

  private

  def internal?(link)
    prefix = %w( http https // )
    # checks whether link contains http or https
    if !prefix.include?(URI.parse(link).scheme)
      true
    else
      link = Addressable::URI.parse(link).host.downcase
      url = Addressable::URI.parse(@url).host.downcase
      link == url
    end
  end

  def check_link_and_save(link)
    @links << link unless @links.include?(link)
  end

end
