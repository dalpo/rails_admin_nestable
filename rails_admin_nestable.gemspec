$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "rails_admin_nestable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "rails_admin_nestable"
  s.version     = RailsAdminNestable::VERSION
  s.authors     = ["Andrea Dal Ponte"]
  s.email       = ["info@andreadalponte.com"]
  s.homepage    = "https://github.com/dalpo/rails_admin_nestable"
  s.summary     = "RailsAdmin Drag and drop tree view for Ancestry gem"
  s.description = "RailsAdmin Drag and drop tree view for Ancestry gem with ActiveRecord and MongoID"
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.1"
  s.add_dependency "rails_admin"
  s.add_dependency "haml-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "sass-rails"
end
