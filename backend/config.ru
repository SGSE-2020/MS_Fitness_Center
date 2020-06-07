require File.expand_path('./src/server.rb', File.dirname(__FILE__))

set :protection, :except => :json_csrf
run API