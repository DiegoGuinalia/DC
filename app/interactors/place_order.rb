class PlaceOrder
  include Interactor::Organizer

  organize Parse::OrderData, Integrate::Order
end
