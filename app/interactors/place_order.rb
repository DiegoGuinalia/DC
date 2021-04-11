class PlaceOrder
  include Interactor::Organizer

  organize Parse::OrderData
end
