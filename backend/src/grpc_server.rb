#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'multi_json'
require 'route_fitness_center_services_pb'
require 'logger'
require_relative 'psql_database'

logger = Logger.new('/proc/1/fd/1')
logger.formatter = proc do |severity, datetime, progname, msg|
    "grpc: #{msg}\n"
end

include Routeguide

class ServerImpl < Routeguide::FitnessCenter::Service
    # Keine Ahnung
    def initialize()
        #puts "init"
    end

    def request_training_plan(request, _call)
        result = post_to_database("INSERT INTO trainingplanrequest (request_date, member_id) VALUES(
            '#{request.date.year}-#{request.date.month}-#{request.date.day}',
            #{request.member_id}
        );")
        if result == '' then
            Confirmation.new(code: 200, description: "Succsessfullly added")
        else
            Confirmation.new(code: 400, description: result)
        end
    end

    def request_physio_appointment(request, _call)
        result = post_to_database("INSERT INTO treatmentrequest (request_date, note, member_id) VALUES(
            '#{request.date.year}-#{request.date.month}-#{request.date.day}',
            '#{request.note}',
            #{request.member_id}
        );")
        if result == '' then
            Confirmation.new(code: 200, description: "Succsessfullly added")
        else
            Confirmation.new(code: 400, description: result)
        end
    end
end

def create_grpc_server
    port = '0.0.0.0:50051'
    s = GRPC::RpcServer.new
    s.add_http2_port(port, :this_port_is_insecure)
    GRPC.logger.info("... running insecurely on #{port}")
    puts "gRPC server build on port #{port}"
    s.handle(ServerImpl.new)
    # Runs the server with SIGHUP, SIGINT and SIGQUIT signal handlers to 
    #   gracefully shutdown.
    # User could also choose to run server via call to run_till_terminated
    #s.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    s
end

def main
    puts 'Initializing things...'
    puts 'This might take some time...'

    grpc = create_grpc_server

    #grpc.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])

    #child_pid = fork do
    puts "Initializing finished"
    grpc.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    #end

    #at_exit do
    #    grpc.stop
    #    t.join()
    #    puts "grpc stopped..."
    #end
end

child_pid = fork do 
    main
end

logger.warn "==== GRPC startet wit PID #{child_pid} ===="

at_exit do
    puts 'Waiting for gRPC sever to teminate'
    Process.kill('SIGQUIT', child_pid)
    Process.wait(child_pid)
    puts 'GRPC server terminated'
end

