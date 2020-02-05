module SpreeDynRelatedProducts
  module Generators
    class InstallGenerator < Rails::Generators::Base

      def add_assets_into_spree_files
        # "Injecting into File" avoids the need to override layouts
        # adding scripts or stylesheets tags lines.
        inject_into_file 'vendor/assets/javascripts/spree/frontend/all.js', "\n//= require dyn_related_products/dyn_related\n", after: "spree/frontend", verbose: true
      end

    end
  end
end