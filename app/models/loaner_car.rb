class LoanerCar < ApplicationRecord
  include ShakenExpiry

  has_many :rentals, dependent: :destroy
end
