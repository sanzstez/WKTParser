Gem::Specification.new do |gem|
  gem.name    = 'wktparser'
  gem.version = '0.1.6'
  gem.date    = Date.today.to_s

  gem.summary     = "Well-Known Text Parser"
  gem.description = "WKT Parser for Ruby made with Parslet"

  gem.authors  = ['Fernando Mumbach']
  gem.email    = 'fermuch@cryptolab.net'
  gem.homepage = 'http://github.com/fermuch/wktparser'

  gem.add_dependency('rake')
  gem.add_dependency('parslet')
  gem.add_development_dependency('rspec', [">= 2.0.0"])

  # ensure the gem is built out of versioned files
  gem.files = Dir['Rakefile', '{bin,lib,man,test,spec}/**/*', 'README*', 'LICENSE*'] & `git ls-files -z`.split("\0")
end
