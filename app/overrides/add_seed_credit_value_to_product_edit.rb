Deface::Override.new(
  virtual_path: 'spree/admin/products/_form',
  name: 'add_seed_credit_value_to_product_edit',
  insert_after: "erb[loud]:contains('text_field :price')",
  text: "
    <%= f.field_container :seed_credit_value, class: ['form-group'] do %>
      <%= f.label :seed_credit_value, raw(Spree.t(:seed_credit_value)) %>
      <%= f.number_field :seed_credit_value,
          value: @product.seed_credit_value,
          class: 'form-control' %>
      <%= f.error_message_on :seed_credit_value %>
    <% end %>
  ")