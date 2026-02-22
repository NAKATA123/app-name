class HomeController < ApplicationController
  def top
    unless logged_in?
      redirect_to login_path, alert: "ログインしてください"
      return
    end

    @reception_count = Repair.reception.count
    @working_count   = Repair.working.count
    @completed_count = Repair.completed.count

    today = Time.zone.today
    @loaned_count = Rental.where("start_date <= ? AND end_date >= ?", today, today).count
    @available_count = [LoanerCar.count - @loaned_count, 0].max
  end
end
