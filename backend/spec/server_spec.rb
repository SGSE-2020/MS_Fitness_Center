require "spec_helper"

RSpec.describe API do
    let(:app) { App.new }

    context "GET to /members" do
      it "returns status 200 OK"
      it "displays a list of member names that link to /members/:name"
    end
end