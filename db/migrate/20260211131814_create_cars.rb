class CreateCars < ActiveRecord::Migration[7.1]
  def change
    create_table :cars do |t|
      t.references :customer, null: false, foreign_key: true
      t.string :car_model
      t.string :car_number

      t.timestamps
    end
  end
end
