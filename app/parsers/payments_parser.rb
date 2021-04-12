# frozen_string_literal: true

class PaymentsParser
  def initialize(params)
    @payments = params[:payments]
  end

  def parse_payments
    payments_parse = []
    @payments.map do |payment|
      payments_parse << {
        type: payment[:payment_type].upcase,
        value: payment[:total_paid_amount]
    }
    end.flatten
  end
end
