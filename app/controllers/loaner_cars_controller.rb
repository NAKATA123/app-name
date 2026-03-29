class LoanerCarsController < ApplicationController
  before_action :require_login

  # =========================
  # 一覧ページ（タブ＋カレンダー用）
  # =========================
  def index
    @loaner_cars = LoanerCar.all.order(created_at: :desc)

    today = Date.today

    # 現在貸出中
    @current_rentals = Rental
      .includes(:loaner_car, repair: { car: :customer })
      .where("start_date <= ? AND end_date >= ?", today, today)
      .order(:start_date)

    # これからの貸出
    @upcoming_rentals = Rental
      .includes(:loaner_car, repair: { car: :customer })
      .where("start_date > ?", today)
      .order(:start_date)

    # カレンダー表示用（すべてのレンタルを取得）
    @rentals = Rental.includes(:loaner_car, repair: { car: :customer })
  end

  # =========================
  # 新規代車登録フォーム
  # =========================
  def new
    @loaner_car = LoanerCar.new
  end

  # =========================
  # 代車作成
  # =========================
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
