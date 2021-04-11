class Order < ApplicationRecord
  has_many :order_items
  belongs_to :customer
  has_one :address
  has_one :payment
end
