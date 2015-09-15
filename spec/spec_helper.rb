ENV["RACK_ENV"] = "test"

require "rspec"
require "rack/test"

Dir["./spec/support/**/*.rb"].each do |file|
  require file
end

def app
  TestApp
end

RSpec.configure do |config|
  config.include Rack::Test::Methods
end