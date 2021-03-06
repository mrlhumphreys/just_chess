# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "just_chess/version"

Gem::Specification.new do |spec|
  spec.name          = "just_chess"
  spec.version       = JustChess::VERSION
  spec.authors       = ["Mark Humphreys"]
  spec.email         = ["mark@mrlhumphreys.com"]

  spec.summary       = %q{A chess engine written in ruby}
  spec.description   = %q{Provides a representation of a chess game complete with rules enforcement and serialisation.}
  spec.homepage      = "https://github.com/mrlhumphreys/just_chess"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 2.7.0'

  spec.add_development_dependency "bundler", "~> 2.1.4"
  spec.add_development_dependency "rake", "~> 13.0.1"
  spec.add_development_dependency "minitest", "~> 5.14.0"

  spec.add_runtime_dependency "board_game_grid", "~> 0.1.6"
end
