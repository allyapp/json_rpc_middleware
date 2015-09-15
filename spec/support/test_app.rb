require "sinatra/base"
require "json"
require "json_rpc"

class TestApp < Sinatra::Base
  configure do
    use Sinatra::JsonRpc::Handler
  end

  AVAILABLE_METHODS = [:valid_method].freeze

  def valid_method(params, request_id)

    if params.has_key?("valid_param")
      [200, { "Content-type" => "application/json" }, {message: "It works!"}.to_json]
    else
      fail Sinatra::JsonRpc::InvalidParametersError
    end
  end

  def available_methods
    AVAILABLE_METHODS
  end

end
