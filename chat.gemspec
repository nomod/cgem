$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chat/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chat"
  s.version     = Chat::VERSION
  s.authors     = ["nomod"]
  s.email       = ["m.ryadn@gmail.com"]
  s.homepage    = "https://github.com/nomod/cgem"
  s.summary     = "A simple rails chat gem that leverages ActionCable"
  s.description = "Denis gem."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency 'rails', '~> 5.0.6'
  s.add_dependency 'sass-rails', '~> 5.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'coffee-rails', '~> 4.2'
  s.add_dependency 'jquery-rails'
  s.add_dependency 'bootstrap-sass'
  s.add_dependency 'bootstrap-sass-extras'
  s.add_dependency 'bcrypt'
  s.add_dependency 'figaro'
  s.add_dependency 'slim'
  s.add_dependency 'slim-rails'

  s.add_development_dependency 'puma', '~> 3.0'
  s.add_development_dependency 'pg'
end