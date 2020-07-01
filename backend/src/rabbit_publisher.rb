require 'bunny'

def new_device(text)
    result = 'success'
    begin
        connection = Bunny.new(:host => "ms-rabbitmq", :port => 5672, :vhost => "/", :user => "testmanager", :password => "sgseistgeil")
        connection.start

        channel = connection.create_channel
        exchange = channel.fanout("fitnesscenter", "fanout")
        #severity = ARGV.shift || 'anonymous.info'
        #message = ARGV.empty? ? 'Hello World!' : ARGV.join(' ')

        #exchange.publish(message, routing_key: severity)
        #puts " [x] Sent #{severity}:#{message}"

        exchange.publish(text)
        connection.close
    rescue Bunny::Exception => e
        result = e.message
        puts e.message
    ensure
        connection.close if connection
    end
    result
end
