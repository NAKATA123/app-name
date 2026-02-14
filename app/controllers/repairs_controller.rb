class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(car: :customer).order(created_at: :desc)
  end

  def show
    @repair = Repair.includes(car: :customer).find(params[:id])
  end

  def new
    @car = Car.find(params[:car_id])
    @repair = @car.repairs.build
  end

  def create
    @car = Car.find(params[:car_id])
    @repair = @car.repairs.build(repair_params)

    if @repair.save
      redirect_to repair_path(@repair), notice: "修理を登録しました"
    else
      render :new
    end
  end

  private

  def repair_params
    params.require(:repair).permit(:description, :status)
  end
end
