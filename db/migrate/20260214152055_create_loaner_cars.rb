class CreateLoanerCars < ActiveRecord::Migration[7.1]
  def change
    create_table :loaner_cars do |t|
      t.string :name
      t.string :car_number

      t.timestamps
    end
  end
end
