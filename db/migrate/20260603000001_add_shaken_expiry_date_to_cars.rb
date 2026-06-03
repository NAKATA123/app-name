class AddShakenExpiryDateToCars < ActiveRecord::Migration[7.1]
  def change
    add_column :cars, :shaken_expiry_date, :date
  end
end
