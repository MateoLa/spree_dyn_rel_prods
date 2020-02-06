module SpreeDynamicRelProds
  class Engine < Rails::Engine
    engine_name 'spree_dynamic_rel_prods'

		config.to_prepare do
		  Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

  end
end
