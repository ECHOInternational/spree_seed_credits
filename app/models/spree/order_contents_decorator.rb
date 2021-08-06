#module Spree
#  OrderContents.class_eval do
#  	def after_add_or_remove(line_item, options = {})
#      order.payments.store_credits.checkout.destroy_all
#      persist_totals
#      shipment = options[:shipment]
#      if shipment.present?
#        # ADMIN END SHIPMENT RATE FIX
#        # refresh shipments to ensure correct shipment amount is calculated when using price sack calculator
#        # for calculating shipment rates.
#        # Currently shipment rate is calculated on previous order total instead of current order total when updating a shipment from admin end.
#        order.refresh_shipment_rates(ShippingMethod::DISPLAY_ON_BACK_END)
#        shipment.update_amounts
#      else
#        order.ensure_updated_shipments
#      end
#      PromotionHandler::Cart.new(order, line_item).activate
#      # Add a seed credit adjustment to every line item when it is added.
#      order.seed_credit.add_adjustment(line_item)
#      Adjustable::AdjustmentsUpdater.update(line_item)
#      TaxRate.adjust(order, [line_item]) if options[:line_item_created]
#      persist_totals
#      line_item
#  	end	
#  end
#end
