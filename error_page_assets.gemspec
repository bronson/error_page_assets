lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'error_page_assets/version'

Gem::Specification.new do |spec|
  spec.name          = "error_page_assets"
  spec.version       = ErrorPageAssets::VERSION
  spec.authors       = ["Scott Bronson"]
  spec.email         = ["brons_errpage@rinspin.com"]
  spec.summary       = "Uses the asset pipeline to generate your static error pages."
  # spec.description   = "Uses the asset pipeline to generate your static error pages."
  spec.homepage      = "http://github.com/bronson/static_error_pages"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
end
