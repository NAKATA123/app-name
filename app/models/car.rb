class Car < ApplicationRecord
  include ShakenExpiry

  belongs_to :customer
  has_many :repairs, dependent: :destroy
end
