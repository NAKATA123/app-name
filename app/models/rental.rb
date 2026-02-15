class Rental < ApplicationRecord
  belongs_to :loaner_car
  belongs_to :repair

  validate :no_double_booking

  private

  def no_double_booking
    return unless start_date && end_date

    overlapping = Rental.where(loaner_car_id: loaner_car_id)
                         .where.not(id: id)
                         .where("start_date <= ? AND end_date >= ?", end_date, start_date)

    if overlapping.exists?
      errors.add(:base, "この代車は指定期間にすでに貸出されています")
    end
  end
end
