class AddDatesToRepairs < ActiveRecord::Migration[7.1]
  def change
    add_column :repairs, :received_at, :date
    add_column :repairs, :completed_at, :date
  end
end
