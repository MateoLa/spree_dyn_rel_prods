module Spree::ProductsControllerDecorator
#  def self.prepended(base)
#    base.before_action :load_product, only: :related
#  end

  def related
    if @product.respond_to?(:has_related_products?)
      super
    else
      @_related_products ||= []
      if @product.taxons.present?
        max_deep = @product.taxons.map { |e| e[:depth] }.max
        taxons = @product.taxons.find_by(depth: max_deep)

        taxons.each do |taxon|
byebug
          @_related_products << taxon.products.
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

#    def load_product
#      @products = if try_spree_current_user.try(:has_spree_role?, 'admin')
#                    Product.with_deleted
#                  else
#                    Product.active(current_currency)
#                  end

#      @product = @products.includes(:master).
#                 friendly.
#                 find(params[:id])
#    end

end

Spree::ProductsController.prepend Spree::ProductsControllerDecorator