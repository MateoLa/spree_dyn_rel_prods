module SpreeDynRelProds
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_assets_into_spree
        # "Injecting to File" avoids the need to override layouts
        # adding scripts or stylesheets tags lines.
        inject_into_file 'vendor/assets/javascripts/spree/frontend/all.js', "\n//= require dyn_rel_prods/dyn_rel_prods", after: "spree/frontend", verbose: true
      end

    end
  end
end
