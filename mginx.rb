require 'net/http'
require 'uri'
require 'yaml'
require 'ostruct'
require_relative './lib/http/methods.rb'
require_relative './lib/http/request_parser.rb'
require_relative './lib/http/response_creator.rb'
require_relative './lib/http/request.rb'
require_relative './lib/mginx_behaviour.rb'
require_relative './lib/mginx.rb'
require_relative './lib/app_server_behaviour.rb'
require_relative './lib/app_server.rb'

server_config = YAML.load_file('./config/app_servers.yml')
mgnix_config =  YAML.load_file('./config/web_server.yml')
mginx_path  = mgnix_config['mgnix_server']
app_servers =  server_config ? AppServerHandler.intialize_servers(server_config.values) : []
Mginx.new(mginx_path, app_servers).run
