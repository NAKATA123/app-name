class CreateRepairs < ActiveRecord::Migration[7.1]
  def change
    create_table :repairs do |t|
      t.references :car, null: false, foreign_key: true
      t.text :description
      t.integer :status

      t.timestamps
    end
  end
end
