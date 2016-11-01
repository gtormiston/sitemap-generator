# Understands a website address
require 'net/ping'
require 'public_suffix'

class Domain

  attr_reader :url

  def initialize(url)
    @url = strip_http(url)
  end

  def status
    if valid?
      check = Net::Ping::External.new(@url)
      check.ping?
    else
      raise "This is not a valid domain"
    end
  end

  def valid?
    PublicSuffix.domain(@url) != nil
  end

  private

  def strip_http(url)
    url.sub(/^https?\:\/\/?/,'')
  end

end
