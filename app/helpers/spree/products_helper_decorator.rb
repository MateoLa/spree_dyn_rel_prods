module Spree::ProductsHelperDecorator

  def related_products

    if @product.respond_to?(:has_related_products?)
      super
    else
      if params[:taxon_id].present? 
        @taxon = Spree::Taxon.find(params[:taxon_id])
      elsif @product.taxons.present?
        max_deep = @product.taxons.maximum(:depth)
        @taxon = @product.taxons.where(depth: max_deep).sample
      end
      if @taxon.present?
        products = @taxon.products.where.not(id: @product.id)
        prod_ids = products.map {|e| e[:id]}
        related_ids = prod_ids.sample(Spree::Config[:products_per_page])
        @_related_products = products.where(id: related_ids).
                                      includes(
                                        :tax_category,
                                        master: [
                                          :prices,
                                          images: { attachment_attachment: :blob}
                                        ]
                                      )
      end
    end

    @_related_products ||= []
  end

#  TODO:
#  The following option doen't work because the need to return an ActiveRecord Relationship.
#  Can't operate with the taxons in the each block because the ActiveRecord relationships
#  are converted to arrays.
#
#      taxons = @product.taxons.where(depth: max_deep)
#
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
end

Spree::ProductsHelper.prepend Spree::ProductsHelperDecorator