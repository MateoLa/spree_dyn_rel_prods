module SpreeDynRelatedProducts
  class Engine < Rails::Engine
    engine_name 'spree_dyn_related_products'

		config.to_prepare do
		  Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

  end
end
