class CustomersController < ApplicationController
  before_action :require_login

  def index
    @q = Customer.ransack(params[:q])
    @customers = @q.result.order(created_at: :desc).page(params[:page]).per(15)
  end

  def new
    @customer = Customer.new
  end

  def show
    @customer = Customer.find(params[:id])
    @cars = @customer.cars
    @repairs = @customer.repairs.includes(:car)
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer), notice: "顧客情報を更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  
  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy
    redirect_to custoemers_path, notice: "顧客を削除しました"
  end

  private

  def customer_params
    params.require(:customer).permit(:name, :phone, :email, :notes)
  end
end
