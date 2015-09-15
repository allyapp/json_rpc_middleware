require_relative "invalid_parameters_error"

module Sinatra
  module JsonRpc
    class Handler
      def initialize(app)
        @app = app
      end

      def call(env)
        @env = env
        unless valid_rpc_method?
          status, headers, body = @app.call(env)
          return [status, headers, body]
        end

        begin
          request_object
          @env["rack.logger"].info(request_object)
          @app.send request_method, request_params, request_id
        rescue NoMethodError
          raise if @app.available_methods.include?(request_method.to_sym)
          error request_id, -32_601, "Method not found"
        rescue JsonRpc::InvalidParametersError
          error request_id, -32_700, "Invalid params"
        rescue JSON::ParserError
          error nil, -32_700, "Parse error"
        end
      end

      def respond_with_error(request_id:, code:, message:)
        error = {
          id:      request_id,
          jsonrpc: "2.0",
          error:   {
            code:    code,
            message: message
          }
        }

        [200, { "Content-type" => "application/json" }, error.to_json]
      end

      def error(id, code, message)
        respond_with_error request_id: id, code: code, message: message
      end

      def request_object
        parse_request_object
      end

      def valid_rpc_method?
        @env["REQUEST_METHOD"] == "POST" && @env["PATH_INFO"] == "/api"
      end

      def request_method
        request_object["method"]
      end

      def request_params
        request_object.fetch("params") do
          {}
        end
      end

      def request_id
        request_object.fetch("id")
      end

      def parse_request_object
        @env["rack.input"].rewind
        JSON[@env["rack.input"].read]
      end
    end
  end
end