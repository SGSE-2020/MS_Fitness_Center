require "spec_helper"
require_relative "../src/psql_database"

# JSON validator
RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"
    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end

RSpec.describe API do
    let(:app) { API.new }

    before(:each) do
      $database_config[:host] = 'localhost'
    end

    context "GET to /locations" do
      let(:response) { get "/locations" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a list of locations" do
        expect(response).to match_response_schema("locations")
      end
    end


    context "GET to /welcome" do
      let(:response) { get "/welcome" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a welcome message" do
        expect(response).to match_response_schema("welcome")
      end
    end


    context "GET to /devices" do
      let(:response) { get "/devices" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a list of devices" do
        expect(response).to match_response_schema("devices")
      end
    end


    context "GET to /courses" do
      let(:response) { get "/courses" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a list of courses" do
        expect(response).to match_response_schema("courses")
      end
    end


    context "GET to /courses" do
      let(:response) { get "/courses" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a list of courses" do
        expect(response).to match_response_schema("courses")
      end
    end


    context "GET to /abo" do
      let(:response) { get "/abo" }

      it "returns status 200 OK" do
        expect(response.status).to eq 200
      end

      it "displays a list of abo" do
        expect(response).to match_response_schema("abo")
      end
    end
end