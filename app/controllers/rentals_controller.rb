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

  def index
    if params[:loaner_car_id]
      @loaner_car = LoanerCar.find(params[:loaner_car_id])
      @rentals = @loaner_car.rentals
                             .includes(repair: { car: :customer })
                             .order(start_date: :asc)
    else
      @rentals = Rental.includes(repair: { car: :customer }, loaner_car: {})
                       .order(start_date: :asc)
    end
  end


  private

  def rental_params
    params.require(:rental).permit(:loaner_car_id, :repair_id, :start_date, :end_date)
  end
end
