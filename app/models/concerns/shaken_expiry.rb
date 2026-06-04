module ShakenExpiry
  extend ActiveSupport::Concern

  included do
    scope :expiring_soon, -> {
      where("shaken_expiry_date IS NOT NULL AND shaken_expiry_date <= ?", Time.zone.today + 3.months)
        .order(:shaken_expiry_date)
    }
  end
end
