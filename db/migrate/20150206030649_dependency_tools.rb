class DependencyTools < ActiveRecord::Migration
  def change
  	add_column :tools, :dependency, :string
  end
end
