#!/usr/bin/env ruby
# -*- coding: utf-8 -*-

this_dir = File.expand_path(File.dirname(__FILE__))
lib_dir = File.join(File.dirname(this_dir), 'lib')
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'grpc'
require 'multi_json'
require 'user_services_pb'
require 'route_fitness_center_services_pb'
require 'logger'

include User
include Routeguide

$microservice_config = {
    host_buergerbuero:       String('ms-buergerbuero')
}

def get_user_information(user_id)
    stub = User::UserService::Stub.new($microservice_config[:host_buergerbuero], :this_channel_is_insecure)

    user_id_messages = UserId.new(uid: user_id)

    response = nil
    begin
        response = stub.get_user(user_id_messages).message
    rescue GRPC::BadStatus => e
        logger = Logger.new('./log')
        logger.formatter = proc do |severity, datetime, progname, msg|
            "api: #{msg}\n"
        end

        logger.warn e.message
        puts e.message
    end
    response
end


def verify_user_token(user_token)
    stub = User::UserService::Stub.new(microservice_config[:host_buergerbuero], :this_channel_is_insecure)
    user_token_messages = UserId.new(token: user_token)

    response = stub.verify_user(user_token_messages)
    response
end


def test_local
    stub = Routeguide::FitnessCenter::Stub.new('localhost:50051', :this_channel_is_insecure)
    date_t = Routeguide::Date.new(day: 10, month: 10, year: 2020, hour: 10, minutes: 10)
    user_token_messages = TrainingPlanRequest.new(member_id: "0", date: date_t)

    response = stub.request_training_plan(user_token_messages)


    logger = Logger.new('./log')
    logger.formatter = proc do |severity, datetime, progname, msg|
        "api: #{msg}\n"
    end
    logger.warn response
end