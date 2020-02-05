module Spree::ProductsHelperDecorator

  def related_products
    if @product.respond_to?(:has_related_products?)
      super
    elsif @product.taxons.present?
#     @product.taxons.present?
      max_deep = @product.taxons.maximum(:depth)
      taxons = @product.taxons.where(depth: max_deep)

      taxons.each do |taxon|
        @_related_products << taxon.products.where.not(id: @product.id).
                                  includes(
                                    :tax_category,
                                    master: [
                                      :prices,
                                      images: { attachment_attachment: :blob },
                                    ]
                                  ).limit(Spree::Config[:products_per_page].div(taxons.length))
                                
      end
  byebug
    @_related_products      
    end
  end

end

Spree::ProductsHelper.prepend Spree::ProductsHelperDecorator