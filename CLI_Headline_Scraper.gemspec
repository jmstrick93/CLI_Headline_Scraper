# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "CLI_Headline_Scraper/version"

Gem::Specification.new do |spec|
  spec.name          = "CLI_Headline_Scraper"
  spec.version       = CLIHeadlineScraper::VERSION
  spec.authors       = ["Jim Stricker"]
  spec.email         = ["jmstricker93@gmail.com"]

  spec.summary       = %q{A headline-scraping CLI program.}
  spec.description   = %q{This program will automatically compile a list of the top three headlines from a wide range of online news sources.  It is intended less as a way to get your news every day, and more as an interesting tool to get a quick snapshot of how the day's top stories are being portrayed across the media ecosystem at a given moment.  For instance, if you wanted to quickly see what is being emphasized in media outlets consisting of different political inclinations or based in different countries, this would allow you to do so quickly, rather than going to all of these websites' homepages manually.}
  spec.homepage      = "https://github.com/jmstrick93/CLI_Headline_Scraper"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "pry", "~> 0.10"

  spec.add_dependency "require_all", "~> 1.4"
end
