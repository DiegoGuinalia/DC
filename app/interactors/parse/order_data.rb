module Parse
  class OrderData
    include Interactor

    delegate :params, to: :context

    def call
      validate
      parse_data
    end
  
    private
  
    def validate
      result = OrderContract.new.call(params.to_unsafe_h)
  
      context.fail!(error: result.errors.to_h) unless result.success?
    end
  
    def parse_data
      customer_context
      order_context
      address_context
      item_context
      payment_context
    end

    def customer_context
      customer_parser = CustomerParser.new(context.params)
      context.customer_data = customer_parser.parse_customer
    end

    def order_context
      order_parser = OrderParser.new(context.params)
      context.order_data = order_parser.parse_order
    end

    def address_context
      address_parser = AddressParser.new(context.params)
      context.address_data = address_parser.parse_address
    end

    def item_context
      items_parser = ItemsParser.new(context.params)
      context.items_data = items_parser.parse_items
    end
    
    def payment_context
      payments_parse = PaymentsParser.new(context.params)
      context.payments_data = payments_parse.parse_payments
    end
  end
end 