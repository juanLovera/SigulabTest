class AddUnitAndVariationAndResourceDescriptionToIncomes < ActiveRecord::Migration
  def change
    add_column :incomes, :unit, :string
    add_column :incomes, :variation, :string
    add_column :incomes, :resource_description, :string
  end
end
