class RepairsController < ApplicationController
  def index
    @repairs = Repair.includes(car: :customer).order(created_at: :desc)
  end

  def show
    @repair = Repair.includes(car: :customer).find(params[:id])
  end
end
