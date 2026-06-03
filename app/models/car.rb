class Car < ApplicationRecord
  belongs_to :customer
  has_many :repairs, dependent: :destroy

  scope :expiring_soon, -> {
    where("shaken_expiry_date IS NOT NULL AND shaken_expiry_date <= ?", Time.zone.today + 3.months)
      .order(:shaken_expiry_date)
  }
end
