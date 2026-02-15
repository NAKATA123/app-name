class CarsController < ApplicationController
  def show
    @car = Car.find(params[:id])
  end

  def edit
    @car = Car.find(params[:id])
  end

  def update
    @car = Car.find(params[:id])
    if @car.update(car_params)
      redirect_to car_path(@car), notice: "車両情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @car = Car.find(params[:id])
    @car.destroy
    redirect_to customer_path(@car.customer), notice: "車両を削除しました"
  end

  private

  def car_params
    params.require(:car).permit(:car_model, :car_number, :customer_id)
  end
end
