module Spree
  OrdersController.class_eval do
      before_action :validate_item_counts, only: [:update, :populate]

      def validate_item_counts
        return unless current_order

        case action_name
        when "populate"
          validate_added_item_count
        when "update"
          validate_updated_items_count
        end
      end

      def validate_updated_items_count
        line_item_params = params.dig(:order, :line_items_attributes)
        return unless line_item_params
        line_item_hash = line_item_params.to_unsafe_hash

        errors = []
        line_item_hash.each do |index, item|
          line_item = Spree::LineItem.find(item[:id])
          variant = line_item.variant
          next unless variant
          next if !variant.items_limited_per_order?

          quantity = item[:quantity].to_i

          if quantity > variant.max_items_allowed_per_order
            params[:order][:line_items_attributes][index][:quantity] = variant.max_items_allowed_per_order
            errors << build_validation_error(variant, quantity)
          end

        end
        fail_validation! errors unless errors.empty?
      end

      def validate_added_item_count
          return unless params[:variant_id] && params[:quantity]
          
          variant = Spree::Variant.find(params[:variant_id])
          
          return unless variant
          
          return if !variant.items_limited_per_order?
          
          quantity = params[:quantity].to_i

          line_item = find_line_item_by_variant variant

          if line_item
            if line_item.quantity + quantity > variant.max_items_allowed_per_order
              params[:quantity] = (variant.max_items_allowed_per_order - line_item.quantity).to_s
              fail_validation! [] << build_validation_error(variant, quantity)
            end
          else
            if quantity > variant.max_items_allowed_per_order
              params[:quantity] = variant.max_items_allowed_per_order.to_s
              fail_validation! [] << build_validation_error(variant, quantity)
            end
          end
      end

      def find_line_item_by_variant variant 
        current_order.line_items.find_by(variant_id: variant.id)
      end

      def build_validation_error variant, count
        # Todo: TRANSLATION!
        "<strong>#{variant.name}:</strong> This item is limited to #{variant.max_items_allowed_per_order} per order."
      end

      def fail_validation! errors
        flash[:error] = "#{errors.join("<br>")}<br> We have updated your order to include the maximum number allowed."
        # Spree won't let you add 0 items.
        redirect_to action: :edit if params[:quantity] == "0"
      end
    end
end