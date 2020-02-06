module Spree::ProductsHelperDecorator

  def related_products
    if @product.respond_to?(:has_related_products?)
      super
    elsif @product.taxons.present?
      max_deep = @product.taxons.maximum(:depth)
      taxon = @product.taxons.where(depth: max_deep).sample
      products = taxon.products.where.not(id: @product.id)
      ids = products.map {|e| e[:id]}
      aux_ids = ids.sample(Spree::Config[:products_per_page])
      @_related_products = products.where(id: aux_ids).
                                        includes(
                                          :tax_category,
                                          master: [
                                            :prices,
                                            images: { attachment_attachment: :blob}
                                          ]
                                        )

#  The following option doen't work because the need to return an ActiveRecord Relationship.
#  Can't operate with the taxons in the each block because the ActiveRecord relationships
#  are converted to arrays.

#      taxons = @product.taxons.where(depth: max_deep)

#      taxons.each do |taxon|
#        @_related_products << taxon.products.where.not(id: @product.id).
#                                includes(
#                                  :tax_category,
#                                  master: [
#                                    :prices,
#                                    images: { attachment_attachment: :blob },
#                                  ]
#                                ).sample(Spree::Config[:products_per_page].div(taxons.length))                             
#      end

      @_related_products      
    end
  end

end

Spree::ProductsHelper.prepend Spree::ProductsHelperDecorator