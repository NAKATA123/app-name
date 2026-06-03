class LoanerCarsController < ApplicationController
  before_action :require_login

  # 一覧（タブ切り替え＋カレンダー）
  def index
    @loaner_cars = LoanerCar.all.order(created_at: :desc)

    today = Time.zone.today

    # 貸出中
    @current_rentals = Rental
      .includes(:loaner_car, repair: { car: :customer })
      .where("start_date <= ? AND end_date >= ?", today, today)
      .order(:start_date)

    # 貸出予定
    @upcoming_rentals = Rental
      .includes(:loaner_car, repair: { car: :customer })
      .where("start_date > ?", today)
      .order(:start_date)

    # カレンダー用イベント
    @rentals = Rental.includes(:loaner_car, repair: { car: :customer })

    @calendar_events = @rentals.map do |r|
      {
        title: "#{r.loaner_car.name} - #{r.repair&.car&.customer&.name}",
        start: r.start_date,
        end: r.end_date + 1.day,
        url: rental_path(r)
      }
    end
  end

  # 新規登録フォーム
  def new
    @loaner_car = LoanerCar.new
  end

  # 登録
  def create
    @loaner_car = LoanerCar.new(loaner_car_params)
    if @loaner_car.save
      redirect_to loaner_cars_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def loaner_car_params
    params.require(:loaner_car).permit(:name, :car_number)
  end
end
