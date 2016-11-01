require 'sinatra/base'

class SitemapGenerator < Sinatra::Base
  get '/' do
    'Hello SitemapGenerator!'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
