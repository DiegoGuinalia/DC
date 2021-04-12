module Integrate
  class Order
    include Interactor

    delegate :params, to: :context

    def call
      send_order
    end

    private

    def send_order
      response = DeliveryCenterFetcher.new.send_order(body.to_json)

      context.fail!(error: response.body) if response.status != 200
    end

    def body
      payload_formated = payload.deep_transform_keys { |key| key.to_s.camelize(:lower) }
      payload_formated['total_shipping'] = payload_formated['totalShipping']

      payload_formated.delete('totalShipping')
      payload_formated
    end

    def payload
      payload = context.order_data.merge(context.address_data)
      .merge(customer: context.customer_data)
      .merge(items: context.items_data)
      .merge(payments: context.payments_data)
    end
  end
end
