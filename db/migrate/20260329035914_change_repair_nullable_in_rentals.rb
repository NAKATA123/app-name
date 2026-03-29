class ChangeRepairNullableInRentals < ActiveRecord::Migration[7.1]
  def change
    change_column_null :rentals, :repair_id, true
  end
end
