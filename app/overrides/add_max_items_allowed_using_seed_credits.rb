Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_max_items_allowed_using_seed_credits_to_product_edit',
  insert_after: "div[data-hook=admin_product_form_price]",
  text: "
    <%= f.field_container :max_items_allowed_using_seed_credits, class: ['form-group'] do %>
      <%= f.label :max_items_allowed_using_seed_credits, raw(Spree.t(:max_items_allowed_using_seed_credits)) %>
      <%= f.number_field :max_items_allowed_using_seed_credits,
          value: @product.max_items_allowed_using_seed_credits,
          class: 'form-control' %>
      <%= f.error_message_on :max_items_allowed_using_seed_credits %>
    <% end %>
  ")
