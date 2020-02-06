//= require dyn_rel_prods/viewport

Spree.routes.product_related = function(id) { return Spree.routes.product(id) + '/related' }

Spree.fetchDynamicRelatedProductcs = function (id, taxon_id, htmlContainer) {
  return $.ajax({
    url: Spree.routes.product_related(id),
    data: "taxon_id=" + taxon_id
  }).done(function (data) {
    htmlContainer.html(data)
    htmlContainer.find('.carousel').carouselBootstrap4()
  })
}

document.addEventListener('turbolinks:load', function () {
  var productDetailsPage = $('body#product-details')

  if (productDetailsPage.length) {
    var productId = $('div[data-related-products]').attr('data-related-products-id')
    var productTaxonId = $('div[data-related-products]').attr('data-related-products-taxon-id')
    var relatedProductsFetched = false
    var relatedProductsContainer = $('#related-products')

    if (!relatedProductsFetched && relatedProductsContainer.length && productId !== '') {
      $(window).on('resize scroll', function () {
        if (!relatedProductsFetched && relatedProductsContainer.isInViewport()) {
          Spree.fetchDynamicRelatedProductcs(productId, productTaxonId, relatedProductsContainer)
          relatedProductsFetched = true
        }
      })
    }
  }
})