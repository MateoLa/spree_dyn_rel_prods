//= require dyn_related_products/viewport

Spree.routes.product_related = function(id) { return Spree.routes.product(id) + '/related' }

Spree.fetchDynRelatedProductcs = function (id, htmlContainer) {
  return $.ajax({
    url: Spree.routes.product_related(id)
  }).done(function (data) {
    htmlContainer.html(data)
    htmlContainer.find('.carousel').carouselBootstrap4()
  })
}

document.addEventListener('turbolinks:load', function () {
  var productDetailsPage = $('body#product-details')

  if (productDetailsPage.length) {
    var productId = $('div[data-related-products]').attr('data-related-products-id')
    var relatedProductsFetched = false
    var relatedProductsContainer = $('#related-products')

    if (!relatedProductsFetched && relatedProductsContainer.length && productId !== '') {
      $(window).on('resize scroll', function () {
        if (!relatedProductsFetched && relatedProductsContainer.isInViewport()) {
          Spree.fetchDynRelatedProductcs(productId, relatedProductsContainer)
          relatedProductsFetched = true
        }
      })
    }
  }
})