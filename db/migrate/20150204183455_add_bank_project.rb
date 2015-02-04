class AddBankProject < ActiveRecord::Migration
  def change
  	add_column :projects, :banco, :integer
  end
end
