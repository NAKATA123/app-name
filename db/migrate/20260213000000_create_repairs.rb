class CreateRepairs < ActiveRecord::Migration[7.1]
  def change
    create_table :repairs, if_not_exists: true do |t|
      t.references :car, null: false, foreign_key: true
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
