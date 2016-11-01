require 'rubygems'
require File.join(File.dirname(__FILE__), 'lib/app.rb')
require 'sass'
require 'sass/plugin/rack'

# use scss for stylesheets
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

run SitemapGenerator
