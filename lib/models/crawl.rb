# understands the content of a web page
require "httparty"
require "uri"
require 'nokogiri'

class Crawl

  attr_reader :url, :pages, :assets, :site

  def initialize(url)
    @url = prepend_http(url)
    @pages = []
    @assets = []
    @site = {}
  end

  def crawl
    uri = URI.parse(@url)
    body = get_body(uri)
    doc = Nokogiri::HTML(body)

    # goes through the HTML and finds the image tags on the site
    # replace this with all assets
    i = 0
    num = doc.xpath("//img").count
    while i < num  do
       puts doc.xpath("//img")[i]['src']
       # check asset is local before saving?
       i +=1
    end

    # add all discovered internal links to array
    # run through this process for each page in the array, checking the links against the array and not adding duplicates
    # check status of each link to ensure they are available
    # store the response.body along with the link in a hash like link:body
    # iterate through the hash to find all the static assets in the
  end

  def get_body(url)
    response = HTTParty.get(url)
    response.body
  end


  private

  def prepend_http(url)
      url = "http://#{url}" unless url=~/^https?:\/\//
  end

end
