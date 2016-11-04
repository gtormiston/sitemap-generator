require 'sinatra/base'
require 'sinatra/flash'
require 'sinatra/json'
require_relative './models/domain'
require_relative './models/crawl'
require_relative './models/printer'

class SitemapGenerator < Sinatra::Base
  register Sinatra::Flash
  enable :sessions

  get '/' do
    @@crawl = nil
    erb :index
  end

  post '/results' do
    @url = Domain.new(params[:url])
    if @url.status
      @@crawl ||= Crawl.new(@url.url)
      Thread.new do # new thread
          @@crawl.crawl
      end
      erb :results
    else
      flash[:domain_error] = "Are you sure #{@url.url} is a domain?"
      redirect '/'
    end
  end

  get '/update' do
    response = {
    :links_found => @@crawl.site_info[:links_found],
    :links_crawled => @@crawl.site_info[:links_crawled],
    :sitemap => print_sitemap_html(@@crawl.processed),
    }
    json response
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
