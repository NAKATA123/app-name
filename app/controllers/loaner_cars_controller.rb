class LoanerCarsController < ApplicationController
  before_action :require_login

  def index
    @loaner_cars = LoanerCar.all.order(created_at: :desc)
  end

  def new
    @loaner_car = LoanerCar.new
  end

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
