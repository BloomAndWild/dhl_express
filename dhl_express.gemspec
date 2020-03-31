
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "dhl_express/version"

Gem::Specification.new do |spec|
  spec.name          = "dhl_express"
  spec.version       = DhlExpress::VERSION
  spec.authors       = ["Ged Dackys"]
  spec.email         = ["ged@bloomandwild.com"]

  spec.summary       = "A Ruby interface to the DHL Express API."
  spec.homepage      = "https://github.com/BloomAndWild/dhl_express"
  spec.license       = "Proprietary"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "pry"
end
