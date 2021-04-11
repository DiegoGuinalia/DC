class Api::V1::OrdersController < ApplicationController
  def normalize_data
    result = PlaceOrder.call(params: params)

    if result.failure?
      body = { result: 'failed', error: result.error }
      return render json: body, :status => :unprocessable_entity
    end
    
    body = { result: 'success' }    
    render json: body
  end
end