class AddId2Tools < ActiveRecord::Migration
  def change
  	add_column :tools, :id2, :string
  end
end
