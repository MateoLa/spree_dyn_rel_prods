Deface::Override.new(
  virtual_path: 'spree/products/show',
  name: 'add_attr_to_products_show',
  add_to_attributes: "[data-related-products]",
  attributes: {:"data-related-products-taxon-id" => "<%= @taxon.present? ? @taxon.id : '' %>"},
  original: 'b7736d9aecaf892a576ad1155a7fa8256f6266f0'
)
