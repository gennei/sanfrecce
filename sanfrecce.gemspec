# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sanfrecce/version'

Gem::Specification.new do |spec|
  spec.name          = "sanfrecce"
  spec.version       = Sanfrecce::VERSION
  spec.authors       = ["gennei"]
  spec.email         = ["sai.gennei@gmail.com"]

  spec.summary       = %q{ command line tool for Sanfrecce Hiroshima Data}
  spec.description   = %q{ command line get infomation from Sanfrecce Hiroshima HP}
  spec.homepage      = "https://github.com/gennei/sanfrecce"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = "sanfrecce"
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'thor', '~> 0.19.1'
  spec.add_runtime_dependency 'nokogiri', '~> 1.6.6.2'
  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3.0'
  spec.add_development_dependency 'simplecov', '~> 0.10.0'
end
