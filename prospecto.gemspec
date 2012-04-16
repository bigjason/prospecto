$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "prospecto/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "prospecto"
  s.version     = Prospecto::VERSION
  s.authors     = ["Jason Webb"]
  s.email       = ["bigjasonwebb@gmail.com"]
  s.homepage    = "http://github.com/bigjason/prospecto"
  s.summary     = "Seperation of views and templates for rails projects."
  s.description = ""

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1.0"

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "turn"
end
