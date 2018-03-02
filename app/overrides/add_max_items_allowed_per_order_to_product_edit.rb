Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_max_items_allowed_per_order_to_product_edit',
  insert_after: "erb[loud]:contains('text_field :price')",
  text: "
    <%= f.field_container :max_items_allowed_per_order, class: ['form-group'] do %>
      <%= f.label :max_items_allowed_per_order, raw(Spree.t(:max_items_allowed_per_order)) %>
      <%= f.number_field :max_items_allowed_per_order,
          value: @product.max_items_allowed_per_order,
          class: 'form-control' %>
      <%= f.error_message_on :max_items_allowed_per_order %>
    <% end %>
  ")