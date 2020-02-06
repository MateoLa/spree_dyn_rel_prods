$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "spree_dynamic_rel_prods/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.platform    = Gem::Platform::RUBY
  spec.name        = "spree_dynamic_rel_prods"
  spec.version     = SpreeDynamicRelProds::VERSION
  spec.authors     = ["VeroLa Srl."]
  spec.email       = ["mateo.laino@gmail.com"]
  spec.homepage    = "https://github.com/MateoLa"
  spec.summary     = "Related Products should be Dynamic. This extension adds to Spree dynamic related products based on its taxons."
  spec.description = spec.summary
  spec.license     = "MIT"


  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"
  spec.add_dependency "spree", "~> 4.0"

  spec.add_development_dependency "sqlite3"
end
