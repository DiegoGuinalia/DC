module Create
  class Order
    include Interactor

    delegate :params, to: :context

    def call
      if order_exists
        within_transaction do
          create_customer
          create_order
          create_address
          create_items
          create_payments
        end
      end
    end

    private

    def order_exists
      !::Order.where(external_code: context.order_data[:external_code]).exists?
    end

    def create_customer
      customer = ::Customer.where(external_code: context.customer_data[:external_code]).first
      if customer.nil?
        return context.customer = Customer.create(context.customer_data)
      end

      customer.update(context.customer_data)
      context.customer = customer
    end

    def create_order
      order = ::Order.where(external_code: context.order_data[:external_code]).first

      context.order_data[:created_at] = context.order_data[:dtOrderCreate]
      context.order_data.delete(:dtOrderCreate)

      if order.nil?
        context.order = context.customer.orders.build(context.order_data)
        return context.order.save
      end

        order.update(context.order_data)
        context.order = order
    end

    def create_address
      context.address = context.order.build_address(context.address_data)
      context.address.save
    end

    def create_payments
      context.payments = context.payments_data.map do |payment_data|
        payment = context.order.payments.build(payment_data)
        payment.save
        payment
      end
    end

    def create_items
      context.items = []
      context.order_items = []

      context.items_data.each do |item_data|
        item = Item.where(external_code: item_data[:external_code]).first
        
          return without_items(item_data) if item.nil?
          with_items(item_data, item)
      end
    end

    def without_items(item_data)
      item = Item.create(item_data.except(:quantity, :total))
      order_item = context.order.order_items.build(item_data.slice(:quantity, :total))
      order_item.item = item
      order_item.save

      context.items << item

      context.order_items << order_item
    end

    def with_items(item_data, item)
      item.update(item_data.except(:quantity, :total))
      order_item = context.order.order_items.build(item_data.slice(:quantity, :total))
      order_item.item = item
      order_item.save

      context.items << item
      context.order_items << order_item
    end

    def within_transaction
      ActiveRecord::Base.transaction do
        begin
          yield
        rescue => error
          @error = error
          raise ActiveRecord::Rollback
        end
      end
    end
  end
end