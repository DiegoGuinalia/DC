# frozen_string_literal: true

class OrderContract < Dry::Validation::Contract
  params do
    required(:id).value(:integer)
    required(:store_id).value(:integer)
    required(:total_amount).value(:float)
    required(:total_shipping).value(:float)
    required(:date_created).value(:date_time)

    required(:shipping).hash do
      required(:receiver_address).hash do
        required(:street_name).value(:string)
        required(:comment).value(:string)
        required(:zip_code).value(:string)
        required(:street_number).value(:string)
        required(:latitude).value(:float)
        required(:longitude).value(:float)

        required(:country).hash do
          required(:id).value(:string)
        end

        required(:state).hash do
          required(:name).value(:string)
        end

        required(:city).hash do
          required(:name).value(:string)
        end

        required(:neighborhood).hash do
          required(:name).value(:string)
        end
      end
    end

    required(:order_items).array(:hash) do
      required(:unit_price).value(:float)
      required(:quantity).value(:integer)

      required(:item).hash do
        required(:id).value(:string)
        required(:title).value(:string)
      end
    end

    required(:payments).array(:hash) do
      required(:payment_type).value(:string)
      required(:total_paid_amount).value(:float)
    end

    required(:buyer).hash do
      required(:id).value(:integer)
      required(:nickname).value(:string)
      required(:email).value(:string)

      required(:phone).hash do
        required(:area_code).value(:integer)
        required(:number).value(:string)
      end
    end
  end

  rule('buyer.email') do
    if !/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i.match?(value)
      key.failure('email invalid format')
    end
  end

  rule('shipping.receiver_address.state.name') do
    if !AddressParser::STATE_OPTIONS.include? :"#{value}"
      key.failure('state invalid')
    end
  end
end
