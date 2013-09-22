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
  s.summary     = "Reorganise model data with a drag and drop tree/list structure"
  s.description = "Rails Admin plugin to organise Tree/List models with a simple drag and drop custom action"
  s.license     = 'MIT'

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", ">= 3.1"
  s.add_dependency "rails_admin"
  s.add_dependency "haml-rails"
  s.add_dependency "coffee-rails"
  s.add_dependency "sass-rails"
end
