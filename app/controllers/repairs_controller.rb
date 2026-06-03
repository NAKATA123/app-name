class RepairsController < ApplicationController
  before_action :require_login

  def index
    @repairs = Repair.includes(car: :customer)
                     .order(created_at: :desc)
                     .page(params[:page])
                     .per(15)
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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @repair = Repair.find(params[:id])
  end

  def update
    @repair = Repair.find(params[:id])
    if @repair.update(repair_params)
      redirect_to repair_path(@repair), notice: "修理情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @repair = Repair.find(params[:id])
    @repair.destroy
    redirect_to repairs_path, notice: "修理を削除しました"
  end



  private

  def repair_params
    params.require(:repair).permit(:description, :status)
  end
end
