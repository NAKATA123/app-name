class Rental < ApplicationRecord
  belongs_to :loaner_car
  belongs_to :repair
end
