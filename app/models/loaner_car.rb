class LoanerCar < ApplicationRecord
  has_many :rentals, dependent: :destroy
end
