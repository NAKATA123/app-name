class Customer < ApplicationRecord
  has_many :cars, dependent: :destroy
  has_many :repairs, through: :cars
end
