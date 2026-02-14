class LoanerCarsController < ApplicationController
  before_action :require_login

  def index
    @loaner_cars = LoanerCar.all.order(created_at: :desc)
  end
end
