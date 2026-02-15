class RentalsController < ApplicationController
  before_action :require_login

  def new
    @repair = Repair.find(params[:repair_id])
    @rental = Rental.new
    @loaner_cars = LoanerCar.all
  end

  def create
    @rental = Rental.new(rental_params)
    if @rental.save
      redirect_to repair_path(@rental.repair)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def rental_params
    params.require(:rental).permit(:loaner_car_id, :repair_id, :start_date, :end_date)
  end
end
