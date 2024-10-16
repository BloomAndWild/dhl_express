# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dhl_express/version"

Gem::Specification.new do |spec|
  spec.name          = "dhl_express"
  spec.version       = DHLExpress::VERSION
  spec.authors       = ["Ged Dackys"]
  spec.email         = ["ged@bloomandwild.com"]

  spec.summary       = "A Ruby interface to the DHL Express API."
  spec.homepage      = "https://github.com/BloomAndWild/dhl_express"
  spec.license       = "Proprietary"

  spec.files         = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Pinned to the same major version as the monolith
  spec.add_dependency "faraday", "~> 1"
end
