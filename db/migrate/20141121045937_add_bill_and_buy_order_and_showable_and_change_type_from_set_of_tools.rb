class AddBillAndBuyOrderAndShowableAndChangeTypeFromSetOfTools < ActiveRecord::Migration
  def change
    add_column :tools, :cost, :decimal
    add_column :tools, :buy_order, :string
    add_column :tools, :adquisition_date, :date
    add_column :tools, :showable, :boolean, :default => true
    remove_column :tools, :from_set, :boolean
    add_column :tools, :from_set, :boolean
  end
end
