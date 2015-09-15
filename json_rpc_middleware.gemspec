# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'json_rpc/version'

Gem::Specification.new do |spec|
  spec.name          = "json_rpc_middleware"
  spec.version       = JsonRpc::VERSION
  spec.authors       = ["tbueno"]
  spec.email         = ["developers@allyapp.com.com"]

  spec.summary       = %q{JSON-RPC Sinatra middleware}
  spec.description   = %q{Middleware to handle json-rpc methods in Sinatra apps}
  spec.homepage      = "https://github.com/allyapp/json_rpc_middleware"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rspec", "~> 3.3"
  spec.add_development_dependency "sinatra", "~> 1.4"
  spec.add_development_dependency "rack-test", "~> 0.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
