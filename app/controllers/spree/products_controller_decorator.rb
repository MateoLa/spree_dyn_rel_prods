module Spree::ProductsControllerDecorator

  def related
    if @product.respond_to?(:has_related_products?)
      super
    else
      @related_products ||= []
      if @product.taxons.present?
        max_deep = @product.taxons.maximum(:depth)
        taxons = @product.taxons.where(depth: max_deep)

        taxons.each do |taxon|
          @related_products |= taxon.products.where.not(id: @product.id).
                                includes(
                                  :tax_category,
                                  master: [
                                    :prices,
                                    images: { attachment_attachment: :blob },
                                  ]
                                ).limit(Spree::Config[:products_per_page].div(taxons.length))
        end
      end
    
      if @related_products.any?
        render template: 'spree/products/related', layout: false
      else
        head :no_content
      end
    end

  end

end

Spree::ProductsController.prepend Spree::ProductsControllerDecorator