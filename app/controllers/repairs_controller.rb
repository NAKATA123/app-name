class RepairsController < ApplicationController
  before_action :require_login

  def index
    @status_filter = params[:status].presence
    @counts = {
      all:       Repair.count,
      reception: Repair.reception.count,
      working:   Repair.working.count,
      completed: Repair.completed.count
    }
    @repairs = Repair.includes(car: :customer).order(created_at: :desc)
    @repairs = @repairs.where(status: @status_filter) if @status_filter
    @repairs = @repairs.page(params[:page]).per(15)
  end

  def show
    @repair = Repair.includes(car: :customer).find(params[:id])
  end

  def new
    @car = Car.find(params[:car_id])
    @repair = @car.repairs.build(received_at: Time.zone.today)
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

  def update_status
    @repair = Repair.find(params[:id])
    attrs = { status: params[:status] }
    attrs[:completed_at] = Time.zone.today if params[:status] == "completed" && @repair.completed_at.nil?
    @repair.update!(attrs)
    redirect_back_or_to repairs_path, notice: "ステータスを更新しました"
  end

  def destroy
    @repair = Repair.find(params[:id])
    @repair.destroy
    redirect_to repairs_path, notice: "修理を削除しました"
  end

  private

  def repair_params
    params.require(:repair).permit(:description, :status, :received_at, :completed_at)
  end
end
