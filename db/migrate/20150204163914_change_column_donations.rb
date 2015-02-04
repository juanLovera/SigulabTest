class ChangeColumnDonations < ActiveRecord::Migration
  def change
  	change_column :donations, :cantidad, :integer, default: 1
  end
end
