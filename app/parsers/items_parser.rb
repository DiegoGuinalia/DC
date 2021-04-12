# frozen_string_literal: true

class ItemsParser
  def initialize(params)
    @order_items = params[:order_items]
  end

  def parse_items
    items_parse = []

    @order_items.map do |order_item|
      items_parse << {
        external_code: order_item[:item][:id],
        name: order_item[:item][:title],
        price: order_item[:unit_price],
        quantity: order_item[:quantity],
        total: order_item[:unit_price]
      }
    end.flatten
  end
end
