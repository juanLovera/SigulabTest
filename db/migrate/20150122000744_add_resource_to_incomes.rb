class AddResourceToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :resource , :integer, :default => 0
  end
end
