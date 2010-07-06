require 'rubygems'
require 'sinatra'
require 'haml'
require 'yaml'
require 'helpers'

set :enviroment, :development

get '/' do
  @title = ''
  haml :index
end

get '/application.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :application
end

get '/rattan.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :rattan
end

get '/doc' do
  @api = YAML.load_file './api.yml'
  @api['actions'] = @api['actions'].sort {|a, b| a[0] <=> b[0]}
  haml :doc
end

get '/:page' do
  @title = ''
  return haml :page_404 unless %w{install doc first_steps examples}.include? params[:page]
  haml params[:page].to_sym
end