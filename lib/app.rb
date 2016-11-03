require 'sinatra/base'
require 'sinatra/flash'
require_relative './models/domain'
require_relative './models/crawl'

class SitemapGenerator < Sinatra::Base
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  post '/results' do
    @url = Domain.new(params[:url])
    if @url.status
      @crawl = Crawl.new(@url)
      erb :results
    else
      erb :index
      flash[:blah] = "There seems to be a problem accessing #{@url.url}."
    end
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
