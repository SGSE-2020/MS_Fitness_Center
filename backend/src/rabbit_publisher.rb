require 'bunny'

def new_device(text)
    result = 'success'
    begin
        connection = Bunny.new(:host => "ms-rabbitmq", :port => 5672, :vhost => "/", :user => "testmanager", :password => "sgseistgeil")
        connection.start

        channel = connection.create_channel
        exchange = channel.fanout("fitnesscenter", :durable => true)

        exchange.publish(text, :app_id => "fitnesscenter", :type => "new.device", :content_type => "application/json")
        connection.close
    rescue Bunny::Exception => e
        result = e.message
        puts e.message
    ensure
        connection.close if connection
    end
    result
end
