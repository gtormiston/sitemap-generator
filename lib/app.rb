require 'sinatra/base'
require_relative './models/domain.rb'

class SitemapGenerator < Sinatra::Base
  get '/' do
    erb :index
  end

  post '/results' do
    @url = params[:url]
    erb :results
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
