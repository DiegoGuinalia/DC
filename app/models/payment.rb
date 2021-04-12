class Payment < ApplicationRecord
  self.inheritance_column = :_type_disabled

  belongs_to :order
end
