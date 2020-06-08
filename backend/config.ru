require File.expand_path('./src/server.rb', File.dirname(__FILE__))
require 'rack/cors'

#set :protection, :except => :json_csrf
#set :protection, :except => [:frame_options, :json_csrf]

use Rack::Cors do
  
    allow do
      origins '*'
      resource '*', headers: :any, methods: :any
  
      # Only allow a request for a specific host
    end
  end

run API