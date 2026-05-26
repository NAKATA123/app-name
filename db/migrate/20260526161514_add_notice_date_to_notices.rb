class AddNoticeDateToNotices < ActiveRecord::Migration[7.1]
  def change
    add_column :notices, :notice_date, :date
    add_index :notices, :notice_date, unique: true
  end
end
