# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'revector/version'

Gem::Specification.new do |spec|
  spec.name          = 'revector'
  spec.version       = Revector::VERSION
  spec.authors       = ['Thadeu Esteves']
  spec.email         = ['tadeuu@gmail.com']
  spec.summary       = 'Simple wrapper to filter array using Ruby and simple predicate conditions'
  spec.description   = 'Filter collections using predicates like Ransack gem.'
  spec.homepage      = 'https://github.com/thadeu/revector'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.required_ruby_version = '>= 2.7.0' # rubocop:disable Gemspec/RequiredRubyVersion
  spec.require_paths = ['lib']

  spec.metadata['rubygems_mfa_required'] = 'true'
end
