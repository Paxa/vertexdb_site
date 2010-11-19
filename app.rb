require 'rubygems'
require 'bundler'

Bundler.require

use Rack::Codehighlighter, :coderay, :element => "pre", :pattern => /\A!!(\w+)\s*\n/

require 'yaml'
require 'helpers'

set :enviroment, :development
set :app_file, $0

before do
  @api = YAML.load_file './api.yml'
  @api['actions'] = @api['actions'].sort {|a, b| a[0] <=> b[0]}
end

get '/' do
  @title = ''
  haml :'pages/index'
end

get '/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end

get '/rattan.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :rattan
end

get '/coderay.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :coderay
end

get '/doc' do
  haml :'pages/doc'
end

get '/:page' do
  @title = ''
  
  if !%w{install doc quick_start guides maintain}.include? params[:page]
    return haml :page_404
  end
  
  haml "pages/#{params[:page]}".to_sym
end