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
  s.summary     = "Organise Ancestry model into a drag and drop tree structure"
  s.description = "Organise Ancestry model into a drag and drop tree structure"

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 3.2"
  s.add_dependency "rails_admin"
end
