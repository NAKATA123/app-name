class HomeController < ApplicationController
  def top
    return unless logged_in?

    today = Time.zone.today.all_day

    @reception_count = Repair.where(status: :reception, created_at: today).count
    @working_count   = Repair.where(status: :working,   created_at: today).count
    @completed_count = Repair.where(status: :completed, created_at: today).count

    # ここ修正
    @loaned_count = Rental.where("end_date >= ?", Date.today).count
    @available_count = LoanerCar.count - @loaned_count
  end
end
