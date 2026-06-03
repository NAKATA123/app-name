class AddShakenExpiryDateToLoanerCars < ActiveRecord::Migration[7.1]
  def change
    add_column :loaner_cars, :shaken_expiry_date, :date
  end
end
